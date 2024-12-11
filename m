Return-Path: <linux-aspeed+bounces-190-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEF7E7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 04:51:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y80RY6fn4z30Sw;
	Thu, 12 Dec 2024 15:51:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733889157;
	cv=none; b=Ct5wOptihjrAc1jAfhlyZhqW9FsbVtOsMBz/XZiZmM4/vEfcFWcSMa+g9egCikoly0R8MVWmdmNgsHMa1h0gGoK/7SvF0RiOgMM43cAj9rfhEL34TNzGhV4bpAUEXyYfjOAHv1vc2GaqRyE6dWNYo6/+vXshYAMuI8TQxk899ZaJ1+hmRcW4HKBpLj2j/XxBN4EbZtebNS6RPI4tZPlVilph4EiA8kVX9ROsudN4ZOYW1X2iFxRCjJ8o8r4ZEpQfva5Cfz93R1hMwburkLdKDU3QzpsQXOnGgQWhEM8c+oByC0JkB8n20woHTtTeoUXzL43kOlNBOzw4vIIHBj5+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733889157; c=relaxed/relaxed;
	bh=C+GRX0w5qrhMggfFHQ6mX+79vq6dxMz/WJh56g9FC0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltUbqom3kF7oISrQ90hbe7/WG9QTUxJfKBnIknFopkRb7VkasA0axqkiqFk7WRgVSV9GX/8hxIoO/D/dxDhRttn7PeTzn3Z5+SWI8eeDoCFOfL7QUvih/pH6KuUc0VNJ76ALg7F/B60lzO2rlF7BJpOjEQorFoM6ZB4VNGWs7juCzUyHOxYDdr9uHY6pX5Ygo9OKgAtLag3d1hslENHuYNSxEVTvFzXd08z5eCYDYiStr78inxDMPQO64UuP6eqMyg94/gioTAHst0yPrz+HuBSVw56s9phUMlYzky9eJs2L4bEcXdeGkcEa0B9Wg6EKDf/pdh1wk3agX2GOWC8I7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key; unprotected) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=W3D1DmvA; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=joe@pf.is.s.u-tokyo.ac.jp; receiver=lists.ozlabs.org) smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=W3D1DmvA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=pf.is.s.u-tokyo.ac.jp (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=joe@pf.is.s.u-tokyo.ac.jp; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7MBD4JMgz305P
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Dec 2024 14:52:36 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so5378418a91.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Dec 2024 19:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733889154; x=1734493954; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+GRX0w5qrhMggfFHQ6mX+79vq6dxMz/WJh56g9FC0w=;
        b=W3D1DmvAVrHq2Ik05b4T8lcysJd0hFZHA+JIF4cowa0ZEbovXHCfCUaLU9R7+fvMFO
         Wz2RtDQlJmMO0gtOY8FtR0Mfub7auwMvtsP2NKvjAkU34/COgEc01biglCKX0ZOEArSP
         tR2DWgVbXg8gztW/CjWAyn52dSyzLpDUhgBxXVha3M+itp0K+jkzzARY5E5NqhwxCJgl
         DlSxCTf0xKPuCxwlq/yL2mvbdmXzVb1r9l04qcM2c4ATGKSPAAnvLlXtp704fVG/gGzX
         0UKVPMr+GUMUUdeR6Q+WT+Vp5zZmB2mZqnBaCZsISfpC8FX75Zh/5bTkPDC3kFhoOoe0
         cyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733889154; x=1734493954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+GRX0w5qrhMggfFHQ6mX+79vq6dxMz/WJh56g9FC0w=;
        b=ABxP4I1Fz0npIK1VrkHg2F7BArIxl/AnUu0QLGEG1a85464kStZw/1nCSvME7rLxjH
         4EED5PfNMm+2mfZhsAmbrXFRhCw9VjgO9eSpX7/yqfCQjyBa6Ifld9H5NmVI9fHpnNJs
         M+hLsVa4scCe/oRESa4JbmWiWNaUnlPXeb9n0rb3u0uEG+bPoWioi/GpP4UrOjo5+J3F
         Lu/yNsLCz0uow7TSB66cMx9oaXuYkYx7nbL7AZAvtqf2ZO++X5Ax42NLGe1B6lCWczfV
         Ot0NidrmrTwFFDj4g8uf4Pk/mhXOFxSMl0lWfbih0j/9Af97u5r6ArFWudkcrfeBm+TU
         TqkQ==
X-Gm-Message-State: AOJu0YwNoo8p5TlH4Bs2vhLUJNTjDscQOlY24O8YngIGDbv4DjSpJKpV
	bPmmUEovOvQkCVaEIUnD0Ve7tx3sapDvvFx3mt0yjW7hhUxyrPflNcX8w/srEJ5et5Rdinp2aw/
	TKeJMOA==
X-Gm-Gg: ASbGncuptXO9shPGK2YBoOgfQgfa/JbAC1RmmJJk4y1wAZ6Ttyb3yTyyBTq29nitKV1
	0jKE3e4cSbri6QFFe9tAEClBAuWJDy0XJmleA65bhjcFu1xnRP7ss0+eXJ+ONR/KeZFsTlcGj0c
	GmDsqyi8NwwMyN5HwWfQl7Af2zCaQCr+f+gHhQxQvRuNBLZA2+FeKX2AYjj5Dncair36L/IbP7C
	pwMF9ZrVCUCvGc0m9oJ4Ly/8lmTfamuiCpGllSyhWsY5+0GZZ5QvXv7Q2Jx4G0dqWk6xbBHD8hO
	dP3ykvV9XvzQLL+iQwXTk47D39N4o8o=
X-Google-Smtp-Source: AGHT+IFU9j6A4f4dkOlhm05C06mcUD5INPOuKPKniRfX9XpXihkV3/diN/mBId8+xhNmucq5MPpArw==
X-Received: by 2002:a17:90b:4b09:b0:2ee:c4f2:a76d with SMTP id 98e67ed59e1d1-2f127fd864amr2107555a91.21.1733889153599;
        Tue, 10 Dec 2024 19:52:33 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f958d6sm10544075a91.17.2024.12.10.19.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 19:52:33 -0800 (PST)
Message-ID: <2ce3a210-7533-4035-a94e-676d4b9f8eae@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 11 Dec 2024 12:52:30 +0900
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: aspeed: deregister a misc device on error
To: Andrew Jeffery <andrew@codeconstruct.com.au>, joel@jms.id.au
Cc: linux-aspeed@lists.ozlabs.org
References: <20241207032504.1203334-1-joe@pf.is.s.u-tokyo.ac.jp>
 <fff9f13e9839c086d566925c9066d885d46130ed.camel@codeconstruct.com.au>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <fff9f13e9839c086d566925c9066d885d46130ed.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

Thank you for your review.

On 12/9/24 09:28, Andrew Jeffery wrote:
> Hi Joe,
> 
> On Sat, 2024-12-07 at 12:25 +0900, Joe Hattori wrote:
>> The error path of aspeed_lpc_enable_snoop() does not deregister the
>> misc
>> device, which results in a memory leak. Therefore, add a
>> misc_deregister() call in the error path.
>>
>> Fixes: 524feb799408 ("soc: add aspeed folder and misc drivers")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>>   drivers/soc/aspeed/aspeed-lpc-snoop.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
>> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
>> index 9ab5ba9cf1d6..083ddf6dcb7a 100644
>> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
>> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
>> @@ -221,6 +221,7 @@ static int aspeed_lpc_enable_snoop(struct
>> aspeed_lpc_snoop *lpc_snoop,
>>                  hicrb_en = HICRB_ENSNP1D;
>>                  break;
>>          default:
>> +               misc_deregister(&lpc_snoop->chan[channel].miscdev);
> 
> We should free the kfifo too.

Yes, fixed in the V2 patch.
> 
> Anyway, all the switch statement is doing is setting up mask metadata,
> the non-default cases don't depend on the acquired resources. I think
> it would make more sense to move it prior to any resource acquisition,
> rather than try to unwind their acquisition in the default case.

Definitely, it only depends on the function arg `channel`. Modified in 
the v2 patch as well.
> 
> Andrew

Best,
Joe

