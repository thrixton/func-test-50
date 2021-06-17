using System;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace Company.Function
{
    public static class QueueTrigger1
    {
        [Function("QueueTrigger1")]
        public static void Run([QueueTrigger("delete-certificate")] string myQueueItem, FunctionContext context)
        //public static void Run([QueueTrigger("myqueue-items", Connection = "odedevresourcesa393c3a_STORAGE")] string myQueueItem,            FunctionContext context)
        {
            var logger = context.GetLogger("QueueTrigger1");
            logger.LogInformation($"C# Queue trigger function processed: {myQueueItem}");
        }
    }
}
