From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 15 Dec 2021 09:59:27 +0800
Subject: [PATCH v2] media: aspeed: move err-handling together to the bottom
In-Reply-To: <20211214155300.0132946e@coco.lan>
References: <20211206004811.1118-1-jammy_huang@aspeedtech.com>
 <20211214155300.0132946e@coco.lan>
Message-ID: <8bc81b12-795e-b7a1-64dd-a15f30c5f19d@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Mauro,

Because I saw similar error-handling in aspeed_video_init(), I just want 
to make it clear and identical.
It's ok if not applied. Just style problem, as you said.

On 2021/12/14 ?? 10:53, Mauro Carvalho Chehab wrote:
> Em Mon, 6 Dec 2021 08:48:11 +0800
> Jammy Huang <jammy_huang@aspeedtech.com> escreveu:
>
>> refine aspeed_video_setup_video() flow.
> Why? It makes no difference where the error handling code is. Let's
> keep it as preferred by the driver's author ;-)
>
> Regards,
> Mauro
>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>> v2:
>>   - remove change-id in comment
>> ---
>>   drivers/media/platform/aspeed-video.c | 24 +++++++++++-------------
>>   1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index fea5e4d0927e..f5c40d6b4ece 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -1641,11 +1641,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>   
>>   	rc = video->ctrl_handler.error;
>>   	if (rc) {
>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>> -		v4l2_device_unregister(v4l2_dev);
>> -
>>   		dev_err(video->dev, "Failed to init controls: %d\n", rc);
>> -		return rc;
>> +		goto err_ctrl_init;
>>   	}
>>   
>>   	v4l2_dev->ctrl_handler = &video->ctrl_handler;
>> @@ -1663,11 +1660,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>   
>>   	rc = vb2_queue_init(vbq);
>>   	if (rc) {
>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>> -		v4l2_device_unregister(v4l2_dev);
>> -
>>   		dev_err(video->dev, "Failed to init vb2 queue\n");
>> -		return rc;
>> +		goto err_vb2_init;
>>   	}
>>   
>>   	vdev->queue = vbq;
>> @@ -1685,15 +1679,19 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>   	video_set_drvdata(vdev, video);
>>   	rc = video_register_device(vdev, VFL_TYPE_GRABBER, 0);
>>   	if (rc) {
>> -		vb2_queue_release(vbq);
>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>> -		v4l2_device_unregister(v4l2_dev);
>> -
>>   		dev_err(video->dev, "Failed to register video device\n");
>> -		return rc;
>> +		goto err_video_reg;
>>   	}
>>   
>>   	return 0;
>> +
>> +err_video_reg:
>> +	vb2_queue_release(vbq);
>> +err_vb2_init:
>> +err_ctrl_init:
>> +	v4l2_ctrl_handler_free(&video->ctrl_handler);
>> +	v4l2_device_unregister(v4l2_dev);
>> +	return rc;
>>   }
>>   
>>   static int aspeed_video_init(struct aspeed_video *video)
>
>
> Thanks,
> Mauro

-- 
Best Regards
Jammy

