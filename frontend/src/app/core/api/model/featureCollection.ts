/**
 * CbrnAlert API
 * No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
 *
 * The version of the OpenAPI document: 1.0
 * 
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */
import { GeoJsonObject } from './geoJsonObject';
import { Feature } from './feature';


/**
 * GeoJSon \'FeatureCollection\' object
 */
export interface FeatureCollection extends GeoJsonObject { 
    features: Array<Feature>;
}
export namespace FeatureCollection {
}


