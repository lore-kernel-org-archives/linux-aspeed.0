Return-Path: <linux-aspeed+bounces-4659-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84468C5AD48
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Aug 2026 14:51:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHP8r5xqjz2y2B;
	Sun, 09 Aug 2026 00:51:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786200668;
	cv=none; b=OqMgAyQZdiO7j4goGj7o5rl9uWqt/81S0h8PqeS9PLe5vAxlAlCZi9JIc1kUMRSnxPWJdIfrrF4+/ncjQlBUCZFXeE0MiVz+0NdljbJIMggUiQddm+pBzu4dANzfIf3Q9DoHxQAxFeTvzVR2SoJ9ovzkgutiflaLfLKSA511MxzcI+iyuEE4qCeMijQX/NmsWnI0ofmAE16xYWmpedEDr7B148RLuA8SIXCAqiBP7bMUdgFAq1+lKtbwIX19hsKBN1j2ZUo1JgWeqROSlYH6rMecCevVOn276p0DEWrKr0hPhbT/cNHZDRbe87JggLtyyXZOMEplJkAFokKJ+0Paow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786200668; c=relaxed/relaxed;
	bh=6+/fm2qOcTXIyjtL2DGzrA32WfRZi/Wok9xvh1oVjxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCbxkGUWOdEFs+a1ChUxP+pVQ/+hYQSXwy2OAeaHp0YZ7DwiepItMb/jkl7ty6SzM18rGboL8xxnU6yF1df+e+eDYsNBayhYkZYyFV6IFsP0vpri6tY3j8d2ZGEAhH2+AptODo7mOGEzXwrzy4MtxaQfXwwdf73DQ2Yu5LP3EZ1IxmDw3h6Km2UHGoO8dRX0cFeCBXMJJHY1Ao5i4Cy5Dwg8uTc8WOgdE7PMwfctPdLmRs6AEIUsR3v+bG0c6FPkj22pr5XT8o5+u+vo3xt9QZMJTD2R5KjxcM0tEDJ1i786HDtu6ZDFe2J169dEJw+zECUCKdJv1DTo8q8sW7ySgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RDO+CJOX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RDO+CJOX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHP8p69fGz2xyh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 00:51:05 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso4917855ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sat, 08 Aug 2026 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786200663; x=1786805463; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+/fm2qOcTXIyjtL2DGzrA32WfRZi/Wok9xvh1oVjxM=;
        b=RDO+CJOXIRsDkLt8RBSVoArJ8qH7USqUNM73exfYXqdEcmyWrjMG8KW0MIkAzWGezN
         Q/WPgZL6KJR9hlk2QDQDWj+reT0P/6eHTQEuU+qJPxGD6z6c4S7JbDhKEuLIRenyDnOk
         bTWxPJDFhS09lxzMLGXtQA3JbhXfE+PQmrhu/D8+tCgJ9h/IKJV5r/CNZRoxGhpoUjJP
         hsR/BmAH32tyElNyk6QoUoAr8rmmPhDZu5UZLRVXKIcUETRBUoOvEN9emW01/OU86x3p
         CxVQGJ7R37M4zo+2nElLpnwBv1jzskQeofHhF0wbbg5CYtCJBo/aoZlZiNDzfxbL/dwo
         nRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200663; x=1786805463;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6+/fm2qOcTXIyjtL2DGzrA32WfRZi/Wok9xvh1oVjxM=;
        b=eSb1ICdShj+Kb607mCgnQmKq5L0k7O97ymuFSXBHCPEatFVOYl42GA262xtaiM0TR9
         OumfyB4fcHKkAVn7Rj6QrQwvsgmtTZHsIl9dc5HYJys7oaHU0KSCoUFUdKC1esqJhcdq
         qDCBjh/OudGGO2cKF/YVu9qYjAGSsA9rGDi+eJjNW9uiY12PXfX7XTKuNN7mrw8g82l7
         /Nj47Pyafw9LEhKDTJH56IGzajfrHdjPP/YjwAREIPlORaL2u9bAEOHEWyGCxO/JDXfw
         KDn4GBv1f07+P8y0oXhLaznD+TwvPylMoHU0bzA4e+BcV0/nHRgN9E5Ndj8kuqgLZzEh
         sbpA==
X-Forwarded-Encrypted: i=1; AHgh+RpOY02oPOBpOAOeJ74nIYJ1rorn2JvZLE/ixRWpnXLo1kH8KcCCQL9nM7cSkauz7eaCiKIOlVs8jtTB++Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMX/fyUCW78IARY81kRrkB0NBFLcWzMvWiOktStnebssgqETZN
	OrlZjLUId6/0K8F9bWWbYbbSXByac9oXlAVkxFJ6hIPJL/HYKrHnUv29
X-Gm-Gg: AR+sD10ig+n5LhD7g1QciQQ8ah2e5Jv2n2Q74WT1mAt19CQkVSWHtegBSdPviKM/Lk3
	XjAS/nu7lH2HE//JByBwxC+dyQyOJ/k38/o4f1P7RvNggkCfNI6Jb5ddlny8hsMAESgtMoNVvnD
	LHvab6o/mAFgoe5p7irn4hpeGebUZJCv3JwOrZ7R7UVPEsO4eCTydN4r3TOGByc0bsHsaOv5RV5
	Cr9FQVSKrwCAvhachCAE3nJpBMTJVBYoDiHFVfMre8+dg8JyeR0SgzW8mEqxtbzDgE5QaDRUJ/1
	aLybIAh7QeHUbmZ3km7pjoX6ITNR5zYNhnOTOX0G2ECxbrYmVm+ao+Gc9waKTfNsPlfGbLNi+ix
	S5c1dA+D7o+AysgvKcTqEQM4EZ3Li6pUPdPqg4RVC5ru4CsTmcmKClQnjODeChpLPcdX6JycU2s
	wb1SI3EBwqNRp3DWX7kPSGxGFvgCVJWr/L9qBtRwVaVsYpgh0QkGJAO/0bKdIF+HUkwhJrbsMZZ
	eOmrk7SMLFtRtZVVJh1/o6eo3IlN7sZ9dfE0w==
X-Received: by 2002:a17:902:e787:b0:2c9:c083:cd50 with SMTP id d9443c01a7336-2d106e333f0mr206689685ad.17.1786200663232;
        Sat, 08 Aug 2026 07:51:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac170sm19398045ad.8.2026.08.08.07.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 07:51:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net>
Date: Sat, 8 Aug 2026 07:51:01 -0700
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
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ
 lookup
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
 <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/26 01:59, Bui Duc Phuc wrote:
> Hi Guenter,
> 
> Thanks for the review.
> 
>>
>> This is wrong. Check the if() path - the code ends up here if pretimeout == 0,
>> even if irq > 0.
>>
> 
> You're right. I misunderstood the condition in the if() path.
> I'll rewrite it as follows:
> 
>   irq = platform_get_irq_optional(pdev, 0);
> +if (irq < 0 && irq != -ENXIO)
> +        return irq;

This is still wrong. If there is no pretimeout, it does not matter if there is an error.

Guenter

> if (data->pretimeout && irq > 0) {
> .....
>   } else {
> - if (irq == -EPROBE_DEFER)
> -       return -EPROBE_DEFER;
>    wdt->wdd.info = &qcom_wdt_info;
>   }
> 
> Best regards,
> Phuc


