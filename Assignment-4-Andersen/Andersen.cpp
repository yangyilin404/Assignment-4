
/**
 * Andersen.cpp
 * Andersen-style inclusion-based pointer analysis
 */

#include "A4Header.h"

using namespace llvm;
using namespace std;

int main(int argc, char** argv)
{
    auto moduleNameVec =
        OptionBase::parseOptions(
            argc,
            argv,
            "Whole Program Points-to Analysis",
            "[options] <input-bitcode...>"
        );

    SVF::LLVMModuleSet::buildSVFModule(moduleNameVec);

    SVF::SVFIRBuilder builder;
    auto pag = builder.build();
    auto consg = new SVF::ConstraintGraph(pag);

    consg->dump();

    Andersen andersen(consg);
    andersen.runPointerAnalysis();
    andersen.dumpResult();

    delete consg;
    SVF::LLVMModuleSet::releaseLLVMModuleSet();

    return 0;
}

void Andersen::runPointerAnalysis()
{
    using SVF::NodeID;

    WorkList<NodeID> worklist;
    pts.clear();

    // Step 1: Initialize points-to sets using Addr edges.
    // o --Addr--> p means o belongs to pts(p).
    for (const auto* edge : consg->getAddrCGEdges())
    {
        NodeID object = edge->getSrcID();
        NodeID pointer = edge->getDstID();

        if (pts[pointer].insert(object).second)
        {
            worklist.push(pointer);
        }
    }

    // Step 2: Iteratively solve constraints.
    while (!worklist.empty())
    {
        NodeID id = worklist.pop();

        SVF::ConstraintNode* node =
            consg->getConstraintNode(id);

        // Snapshot the current points-to set.
        const std::set<unsigned> pointees = pts[id];

        // Step 3: Process Load and Store constraints.
        for (NodeID object : pointees)
        {
            // Load:
            // q = *p
            // For each object in pts(p), add Copy(object, q).
            for (const auto* load : node->getLoadOutEdges())
            {
                NodeID destination = load->getDstID();

                if (consg->addCopyCGEdge(object, destination))
                {
                    worklist.push(object);
                }
            }

            // Store:
            // *p = q
            // For each object in pts(p), add Copy(q, object).
            for (const auto* store : node->getStoreInEdges())
            {
                NodeID source = store->getSrcID();

                if (consg->addCopyCGEdge(source, object))
                {
                    worklist.push(source);
                }
            }
        }

        // Step 4: Process Copy constraints.
        // p --Copy--> q implies pts(p) is a subset of pts(q).
        for (const auto* copy : node->getCopyOutEdges())
        {
            NodeID destination = copy->getDstID();

            for (NodeID object : pointees)
            {
                if (pts[destination].insert(object).second)
                {
                    worklist.push(destination);
                }
            }
        }

        // Step 5: Process GEP constraints.
        // Handle field-sensitive object offsets.
        for (const auto* edge : node->getGepOutEdges())
        {
            const auto* gep =
                static_cast<const SVF::GepCGEdge*>(edge);

            NodeID destination = edge->getDstID();

            for (NodeID object : pointees)
            {
                NodeID fieldObject =
                    consg->getGepObjVar(object, gep);

                if (pts[destination].insert(fieldObject).second)
                {
                    worklist.push(destination);
                }
            }
        }
    }
}
