From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Date: Sat, 24 Dec 2022 15:35:36 +0800
Subject: [PATCH v3] usb: gadget: aspeed_udc: Add check for dma_alloc_coherent
Message-ID: <20221224073536.24889-1-jiasheng@iscas.ac.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 23, 2022 at 10:54:37PM +0800, Greg KH wrote:
>> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
>> index 01968e2167f9..7dc2457c7460 100644
>> --- a/drivers/usb/gadget/udc/aspeed_udc.c
>> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
>> @@ -1516,6 +1516,10 @@ static int ast_udc_probe(struct platform_device *pdev)
>>  					  AST_UDC_EP_DMA_SIZE *
>>  					  AST_UDC_NUM_ENDPOINTS,
>>  					  &udc->ep0_buf_dma, GFP_KERNEL);
>> +	if (!udc->ep0_buf) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>>  
>>  	udc->gadget.speed = USB_SPEED_UNKNOWN;
>>  	udc->gadget.max_speed = USB_SPEED_HIGH;
>> -- 
>> 2.25.1
>> 
> 
> Why is this just a duplicate of the patch previously submitted here:
> 	https://lore.kernel.org/r/20221125092833.74822-1-yuancan at huawei.com
> 
> confused,
> 
> greg k-h

Yes, it is the same as mine.
As the previous patch had not been merged into the Linux kernel,
my tool found the same error and report it.
And both of us chose the most concise way to fix the error.
That is why the patches are the same.

Thanks,
Jiang

