From: Kunwu Chan <chentao@kylinos.cn>
Date: Thu, 11 Jan 2024 17:31:35 +0800
Subject: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in
 ast_vhub_alloc_epn
In-Reply-To: <2023112236-bullseye-pranker-491e@gregkh>
References: <20231122014212.304254-1-chentao@kylinos.cn>
 <2023112236-bullseye-pranker-491e@gregkh>
Message-ID: <346b631c-8b46-4b41-9188-8cbaaa1ff178@kylinos.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sorry, I didn't find out about this email until now because it was 
intercepted by my company's email server.

On 2023/11/22 20:10, Greg KH wrote:
> On Wed, Nov 22, 2023 at 09:42:12AM +0800, Kunwu Chan wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
>> index 148d7ec3ebf4..e0854e878411 100644
>> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
>> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
>> @@ -826,6 +826,8 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct ast_vhub_dev *d, u8 addr)
>>   	ep->vhub = vhub;
>>   	ep->ep.ops = &ast_vhub_epn_ops;
>>   	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
>> +	if (!ep->ep.name)
>> +		return NULL;
> 
> This will break things if this ever triggers.  How was this tested?  The
It's my fault, I think it's too simplistic. Compiled test only.
Cause I don't know how to test effectively. I didn't find a way to test 
this in 'Documentation/usb/gadget-testing.rst'.
> "slot" for this device will still be seen as used and so the resources
> never freed and then you can run out of space for real devices, right?
> 
> Looks like the other error handling in this function below this call is
> also broken, can you fix that up too?Yes, after reading the relevant code, I found that this is indeed a problem.
So I write the v2 patch below, but the same question bothering me, about 
how to test effectively and what hardware equipment is needed? I'm new 
to this area, do you have any suggestions?

The v2 patch look like:
@@ -826,6 +826,9 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct 
ast_vhub_dev *d, u8 addr)
  	ep->vhub = vhub;
  	ep->ep.ops = &ast_vhub_epn_ops;
  	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
+	if (!ep->ep.name)
+		goto fail_name;
+
  	d->epns[addr-1] = ep;
  	ep->epn.g_idx = i;
  	ep->epn.regs = vhub->regs + 0x200 + (i * 0x10);
@@ -834,11 +837,9 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct 
ast_vhub_dev *d, u8 addr)
  				     AST_VHUB_EPn_MAX_PACKET +
  				     8 * AST_VHUB_DESCS_COUNT,
  				     &ep->buf_dma, GFP_KERNEL);
-	if (!ep->buf) {
-		kfree(ep->ep.name);
-		ep->ep.name = NULL;
-		return NULL;
-	}
+	if (!ep->buf)
+		goto fail_dma;
+
  	ep->epn.descs = ep->buf + AST_VHUB_EPn_MAX_PACKET;
  	ep->epn.descs_dma = ep->buf_dma + AST_VHUB_EPn_MAX_PACKET;

@@ -851,4 +852,21 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct 
ast_vhub_dev *d, u8 addr)
  	ep->ep.caps.dir_out = true;

  	return ep;
+
+/* Free name & DMA buffers */
+fail_dma:
+	dma_free_coherent(&vhub->pdev->dev,
+				     AST_VHUB_EPn_MAX_PACKET +
+				     8 * AST_VHUB_DESCS_COUNT,
+				     ep->buf, ep->buf_dma);
+	ep->buf = NULL;
+	kfree(ep->ep.name);
+	ep->ep.name = NULL;
+
+/* Mark free */
+fail_name:
+	ep->dev->epns[ep->d_idx - 1] = NULL;
+	ep->dev = NULL;
+
+	return NULL;
  }



> 
> thanks,
> 
> greg k-h
-- 
Thanks,
   Kunwu

