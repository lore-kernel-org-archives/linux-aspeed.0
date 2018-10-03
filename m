From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 3 Oct 2018 15:26:53 -0500
Subject: [PATCH v3 2/2] media: platform: Add Aspeed Video Engine driver
In-Reply-To: <a78d4c7a-ac58-c23d-a683-23dce54be993@xs4all.nl>
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
 <1537903629-14003-3-git-send-email-eajames@linux.ibm.com>
 <a78d4c7a-ac58-c23d-a683-23dce54be993@xs4all.nl>
Message-ID: <8ca47483-5347-c40d-0d01-4f13e88f8cde@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 09/28/2018 06:30 AM, Hans Verkuil wrote:
> On 09/25/2018 09:27 PM, Eddie James wrote:
>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>> can capture and compress video data from digital or analog sources. With
>> the Aspeed chip acting a service processor, the Video Engine can capture
>> the host processor graphics output.
>>
>> Add a V4L2 driver to capture video data and compress it to JPEG images.
>> Make the video frames available through the V4L2 streaming interface.
>>
>> +		memcpy(&table[base], aspeed_video_jpeg_dct[i],
>> +		       sizeof(aspeed_video_jpeg_dct[i]));
>> +
>> +		base += ASPEED_VIDEO_JPEG_DCT_SIZE;
>> +		memcpy(&table[base], aspeed_video_jpeg_quant,
>> +		       sizeof(aspeed_video_jpeg_quant));
>> +
>> +		if (yuv420)
>> +			table[base + 2] = 0x00220103;
>> +	}
>> +}
>> +
>> +static void aspeed_video_update(struct aspeed_video *video, u32 reg,
>> +				unsigned long mask, u32 bits)
> You probably want to use u32 for the mask.

Using a u32 there results in:

warning: large integer implicitly truncated to unsigned type [-Woverflow]

everywhere I call aspeed_video_update. Not sure what the deal is. Any 
suggestions?

Thanks,
Eddie

>
>> +{
>> +	u32 t = readl(video->base + reg);
>> +	u32 before = t;
>> +
>> +	t &= mask;
>> +	t |= bits;
>> +	writel(t, video->base + reg);
>> +	dev_dbg(video->dev, "update %03x[%08x -> %08x]\n", reg, before,
>>
>> +
>> +module_platform_driver(aspeed_video_driver);
>> +
>> +MODULE_DESCRIPTION("ASPEED Video Engine Driver");
>> +MODULE_AUTHOR("Eddie James");
>> +MODULE_LICENSE("GPL v2");
>>
> Regards,
>
> 	Hans
>

