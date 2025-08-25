import { handleEvent } from "./src/app/eventHandler.js";
import { wrapper } from "compatibility-layer";

export const handler = wrapper(handleEvent);