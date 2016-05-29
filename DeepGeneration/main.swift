//
//  main.swift
//  DeepGeneration
//
//  Created by Alicia Cicon on 3/28/15.
//  Copyright (c) 2015 Alicia Cicon. All rights reserved.
//

import Foundation



let networkio = NetworkIO()
let fileio = FileStringIO(root:"\(NSHomeDirectory())/Documents/Research/Masters/Projects/DeepGeneration/Data/")


print("INFO: using directory",fileio.root)
///////////////////////////////////////////////////////
// A_TRAIN
// A_TEST
///////////////////////////////////////////////////////
//println("\n\n\nA_TRAIN\nA_TEST\n\n\n")
//
//let a_train_export = Dataset<Float,Float>(features:100, outputs:1)
//
//for _ in 0..<500
//{
//    if (coinFlip())
//    {
//        let randomSquareVector = imageToFloatGrid(randomSquare()).toVector()
//        a_train_export.addInstance(randomSquareVector, outputVector:[Float(0.0)])
//    }
//    else
//    {
//        let randomCircleVector = imageToFloatGrid(randomCircle()).toVector()
//        a_train_export.addInstance(randomCircleVector, outputVector:[Float(1.0)])
//    }
//}
//
//let a_train_export_string = datasetToString(a_train_export)
//fileio.writeStringToFile("A_Train", ext:"arff", contents:a_train_export_string)
//
//let a_test_export = Dataset<Float,Float>(features:100, outputs:1)
//
//for _ in 0..<250
//{
//    if (coinFlip())
//    {
//        let randomSquareVector = imageToFloatGrid(randomSquare()).toVector()
//        a_test_export.addInstance(randomSquareVector, outputVector:[Float(0.0)])
//    }
//    else
//    {
//        let randomCircleVector = imageToFloatGrid(randomCircle()).toVector()
//        a_test_export.addInstance(randomCircleVector, outputVector:[Float(1.0)])
//    }
//}
//
//let a_test_export_string = datasetToString(a_train_export)
//fileio.writeStringToFile("A_Test", ext:"arff", contents:a_test_export_string)

///////////////////////////////////////////////////////
// MLP-1
///////////////////////////////////////////////////////
print("\n\n\nMLP-1\n\n\n")

let a_train_import_for_mlp_string = fileio.stringFromFile("A_Train", ext:"arff")!
let a_train_import_for_mlp = datasetFromString(a_train_import_for_mlp_string)

let a_test_import_for_mlp_string = fileio.stringFromFile("A_Test", ext:"arff")!
let a_test_import_for_mlp = datasetFromString(a_test_import_for_mlp_string)

let mlp_1_original = SingleLayerBackpropNet(inputNodes:100, hiddenNodes:20, outputNodes:1)

mlp_1_original.trainAndTestOnDataset(a_train_import_for_mlp, testSet:a_test_import_for_mlp, maxEpochs:10, maxInstances:0, sse:false)

// EXPORT THE NET
let mlp_1_string_export = networkio.exportWeights(mlp_1_original, half:false)
fileio.writeStringToFile("MLP_1", ext:"txt", contents:mlp_1_string_export)

///////////////////////////////////////////////////////
// AE-1
///////////////////////////////////////////////////////
print("\n\n\nAE-1\n\n\n")

let a_train_import_for_ae_string = fileio.stringFromFile("A_Train", ext:"arff")!
let a_train_import_for_ae = datasetFromString(a_train_import_for_ae_string)
let a_ae_train_original = autoencodeDataset(a_train_import_for_ae, denoise: true, denoisePercent: 0.10)

let a_test_import_for_ae_string = fileio.stringFromFile("A_Test", ext:"arff")!
let a_test_import_for_ae = datasetFromString(a_test_import_for_ae_string)
let a_ae_test_original = autoencodeDataset(a_test_import_for_ae, denoise: false, denoisePercent: 0.00)

print("\nAE_1-20\n")
// Create autoencoder
let ae_1_original_20 = SingleLayerBackpropNet(inputNodes:100, hiddenNodes:20, outputNodes:100)

// Train and Test the autoencoder
ae_1_original_20.trainAndTestOnDataset(a_ae_train_original, testSet:a_ae_test_original, maxEpochs:20, maxInstances:0, sse:true)

// Export the autoencoder
let ae_1_original_20_export_string = networkio.exportWeights(ae_1_original_20, half:false)
fileio.writeStringToFile("AE_1-100-20-100", ext:"txt", contents:ae_1_original_20_export_string)



print("\nAE_1-50\n")
// Create autoencoder
let ae_1_original_50 = SingleLayerBackpropNet(inputNodes:100, hiddenNodes:50, outputNodes:100)

// Train and Test the autoencoder
ae_1_original_50.trainAndTestOnDataset(a_ae_train_original, testSet:a_ae_test_original, maxEpochs:20, maxInstances:0, sse:true)

// Export the autoencoder
let ae_1_original_50_export_string = networkio.exportWeights(ae_1_original_50, half:false)
fileio.writeStringToFile("AE_1-100-50-100", ext:"txt", contents:ae_1_original_50_export_string)


print("\nAE_1-100\n")
// Create autoencoder
let ae_1_original_100 = SingleLayerBackpropNet(inputNodes:100, hiddenNodes:100, outputNodes:100)

// Train and Test the autoencoder
ae_1_original_100.trainAndTestOnDataset(a_ae_train_original, testSet:a_ae_test_original, maxEpochs:20, maxInstances:0, sse:true)

// Export the autoencoder
let ae_1_original_100_export_string = networkio.exportWeights(ae_1_original_100, half:false)
fileio.writeStringToFile("AE_1-100-100-100", ext:"txt", contents:ae_1_original_100_export_string)



print("\nAE_1-200\n")
// Create autoencoder
let ae_1_original_200 = SingleLayerBackpropNet(inputNodes:100, hiddenNodes:200, outputNodes:100)

// Train and Test the autoencoder
ae_1_original_200.trainAndTestOnDataset(a_ae_train_original, testSet:a_ae_test_original, maxEpochs:20, maxInstances:0, sse:true)

// Export the autoencoder
let ae_1_original_200_export_string = networkio.exportWeights(ae_1_original_200, half:false)
fileio.writeStringToFile("AE_1-100-200-100", ext:"txt", contents:ae_1_original_200_export_string)


///////////////////////////////////////////////////////
// B_Train
// B_Test
///////////////////////////////////////////////////////
//println("\n\n\nB_TRAIN\n_B_TEST\n\n\n")
//let a_train_import_for_transform_string = fileio.stringFromFile("A_Train", ext:"arff")!
//let a_train_import_for_transform = datasetFromString(a_train_import_for_transform_string)
//
//let a_test_import_for_transform_string = fileio.stringFromFile("A_Test", ext:"arff")!
//let a_test_import_for_transform = datasetFromString(a_test_import_for_transform_string)
//
//let ae_string_1 = fileio.stringFromFile("AE_1", ext:"txt")!
//let ae_1_transformer = networkio.transformLayerFromString(ae_string_1)
//
//let b_train_export = transformDataSet(a_train_import_for_transform, ae_1_transformer)
//let b_train_export_string = datasetToString(b_train_export)
//fileio.writeStringToFile("B_Train", ext:"arff", contents:b_train_export_string)
//
//let b_test_export = transformDataSet(a_test_import_for_transform, ae_1_transformer)
//let b_test_export_string = datasetToString(b_test_export)
//fileio.writeStringToFile("B_Test", ext:"arff", contents:b_test_export_string)

print("derp")