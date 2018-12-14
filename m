From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 14 Dec 2018 09:41:47 -0600
Subject: [PATCH v8 2/2] media: platform: Add Aspeed Video Engine driver
In-Reply-To: <CACPK8XdQbq-9MbP7uMemyp0=Q+t1qnWNREdZRiyEcrART9vRig@mail.gmail.com>
References: <1544547421-25724-1-git-send-email-eajames@linux.ibm.com>
 <1544547421-25724-3-git-send-email-eajames@linux.ibm.com>
 <CACPK8XdQbq-9MbP7uMemyp0=Q+t1qnWNREdZRiyEcrART9vRig@mail.gmail.com>
Message-ID: <34bb2594-b0ab-f3a0-4d46-ba9a870c958b@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 12/13/2018 07:09 PM, Joel Stanley wrote:
> On Wed, 12 Dec 2018 at 04:09, Eddie James <eajames@linux.ibm.com> wrote:
>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>> can capture and compress video data from digital or analog sources. With
>> the Aspeed chip acting a service processor, the Video Engine can capture
>> the host processor graphics output.
>> +ASPEED VIDEO ENGINE DRIVER
>> +M:     Eddie James <eajames@linux.ibm.com>
>> +L:     linux-media at vger.kernel.org
>> +L:     openbmc at lists.ozlabs.org (moderated for non-subscribers)
> We tend to use the linux-aspeed list for upstream kernel discussions.
> Up to you if you want to use the openbmc list though.
>
>>   source "drivers/media/platform/omap/Kconfig"
>>
>> +config VIDEO_ASPEED
>> +       tristate "Aspeed AST2400 and AST2500 Video Engine driver"
>> +       depends on VIDEO_V4L2
>> +       select VIDEOBUF2_DMA_CONTIG
>> +       help
>> +         Support for the Aspeed Video Engine (VE) embedded in the Aspeed
>> +         AST2400 and AST2500 SOCs. The VE can capture and compress video data
>> +         from digital or analog sources.
> This might need updating in response to my questions below about
> ast2400 testing.
>
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -0,0 +1,1729 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> You need to put this there as well:
>
> // Copyright 2018 IBM Corp
>
>
>> +static int aspeed_video_init(struct aspeed_video *video)
>> +{
>> +       int irq;
>> +       int rc;
>> +       struct device *dev = video->dev;
>> +
>> +       irq = irq_of_parse_and_map(dev->of_node, 0);
>> +       if (!irq) {
>> +               dev_err(dev, "Unable to find IRQ\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       rc = devm_request_irq(dev, irq, aspeed_video_irq, IRQF_SHARED,
> The datasheet indicates this IRQ is for the video engline only, so I
> don't think you want IRQF_SHARED.
>
>> +                             DEVICE_NAME, video);
>> +       if (rc < 0) {
>> +               dev_err(dev, "Unable to request IRQ %d\n", irq);
>> +               return rc;
>> +       }
>> +
>> +       video->eclk = devm_clk_get(dev, "eclk");
>> +       if (IS_ERR(video->eclk)) {
>> +               dev_err(dev, "Unable to get ECLK\n");
>> +               return PTR_ERR(video->eclk);
>> +       }
>> +
>> +       video->vclk = devm_clk_get(dev, "vclk");
>> +       if (IS_ERR(video->vclk)) {
>> +               dev_err(dev, "Unable to get VCLK\n");
>> +               return PTR_ERR(video->vclk);
>> +       }
>> +
>> +       video->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +       if (IS_ERR(video->rst)) {
>> +               dev_err(dev, "Unable to get VE reset\n");
>> +               return PTR_ERR(video->rst);
>> +       }
> As discussed in the clock driver, this can go as you've already
> released the reset when enabling the eclk.

I use the reset control by itself during a resolution change, so I would 
like to have it available.

>
> However, you're requesting the clock without enabling it. You need to
> do a clk_prepare_enable().

That's because the clock is only enabled when the device is opened. No 
reason to turn it on at boot time.

>
>> +
>> +       rc = of_reserved_mem_device_init(dev);
>> +       if (rc) {
>> +               dev_err(dev, "Unable to reserve memory\n");
>> +               return rc;
>> +       }
>> +
>> +       rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +       if (rc) {
>> +               dev_err(dev, "Failed to set DMA mask\n");
>> +               of_reserved_mem_device_release(dev);
>> +               return rc;
>> +       }
>> +
>> +       if (!aspeed_video_alloc_buf(video, &video->jpeg,
>> +                                   VE_JPEG_HEADER_SIZE)) {
>> +               dev_err(dev, "Failed to allocate DMA for JPEG header\n");
>> +               of_reserved_mem_device_release(dev);
>> +               return rc;
>> +       }
>> +
>> +       aspeed_video_init_jpeg_table(video->jpeg.virt, video->yuv420);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id aspeed_video_of_match[] = {
>> +       { .compatible = "aspeed,ast2400-video-engine" },
> I noticed the clock driver did not have the changed required for the
> 2400. Have you tested this on the ast2400?

The clocking setup is different on the ast2400. Xiuzhi on the openbmc 
list has been testing on the ast2400 successfully.

Thanks,
Eddie

>
>
>> +       { .compatible = "aspeed,ast2500-video-engine" },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
>> +
>> +static struct platform_driver aspeed_video_driver = {
>> +       .driver = {
>> +               .name = DEVICE_NAME,
>> +               .of_match_table = aspeed_video_of_match,
>> +       },
>> +       .probe = aspeed_video_probe,
>> +       .remove = aspeed_video_remove,
>> +};

