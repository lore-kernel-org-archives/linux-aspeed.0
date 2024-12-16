Return-Path: <linux-aspeed+bounces-256-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5BCE7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 18:47:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBpph2QlKz2xGH;
	Tue, 17 Dec 2024 05:47:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734374860;
	cv=none; b=LYFGCREmMoz1WQB9pN4YAEIQCI6rJWzMR8AOcJXxDDSBosQtIBFDDuaQN9So/rm61CjW5+Nr/ahPUH2Bava4oBf8EmOuuEV2U5fTd2Eg4sVYnvCMbHadahrobysjkztz6VAhedrmOEVkbVbKcrKppsZPhZnO76nXpavATGzVE01P9CWeATKmWlLq1ep64O9qzqfedQuSTs55nDv6opej5vGmxeBpdXYCtDzUDiPv+BB+2+ObdZW7XQPUoINRocfKe5KUU5yKVtW1/3xPQAr6sIHlUh4a+jNyy89NQYAq7m+kjTPlpYQ2HwstD1cBZHiFNb65DCXtdmcv72skfLEObA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734374860; c=relaxed/relaxed;
	bh=CqFXFmSmKLaSa4Vhvi8HNeoTtmpRApxU91TTMrXkHTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hha0PE4cROFwnIwbdKLXf+HmZl0y5DyikNen2Z9SRft9+yXfXpM15tPXcVqYtb81pTcYH1DJZKBVfiwSVGOs58Ny74HtYrscccKK9hzfRK9RYRWHgPS61k7M5lcxd+hE906RvxfQKEPurLHGVHVc4QpWRnnHHsRCOso64T5Fx7XD3o7+cdNdvk0lIfIkRZahiYD5jmYG0mufseue0HcqS7ZswJAv8sx0MiGcGEodoEBdD/tVNPFohGgJ/pg0C/fygHe6oNDa0+orAl4U9ILDCwKOuiMGg2DXf+7TLC9a33jJy9XRdg2eRkg/ZKt6qCHd3vRuT2qc0+1e/XSLK9vgjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DUGZ3Xhi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DUGZ3Xhi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBppg3MC1z2xCW
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 05:47:39 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-218c8aca5f1so2516105ad.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 10:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734374857; x=1734979657; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CqFXFmSmKLaSa4Vhvi8HNeoTtmpRApxU91TTMrXkHTg=;
        b=DUGZ3XhiVVH1QYCfD0gepgnG0tdzdbpjYgUqtVlCD4f3Rmg+3iIkL0bSXmnPplfw51
         ezwb4GXLJOZ3A5cV595Hla++eSi+1CgeQ8vLhYVoWJahJ7u742vzqyiIXswiUsSng+GG
         BtuETY1E8+U5OoFEVu4ss3cV6mXh4kQGWo/+JSncoHy1ZVXZ+8QsICVKOQdIIVfat7tv
         Qd5al/tsEG+wLomQMJAOvIZWr1IM9lD6Q7CSdl28apTPxL5WM4jP7kPmTD0p3GHEZUdf
         Zjszr7K9gJPp2rfuu08CZ/VtPXr1a2H1vZquMm7nzcfZNUhr1yuZDp+ymin3orwyuZ2y
         zFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734374857; x=1734979657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqFXFmSmKLaSa4Vhvi8HNeoTtmpRApxU91TTMrXkHTg=;
        b=uW+1dMS0crTFV0B7IaToMvKoa9pBIwIQt6odO6vrMfd/pcYqHFLcUwkwv8J003VM0r
         cc0AmHsfChQ46THF11z2oCX1gcI2JFmzYUp48a4gnSdKCVXuQTCYUIgKwoBsiEO9ByK+
         XlEr14uIKXC29C8IHhE0+8zyXus5USC7YPJc+BlPFp23AIp9J/qwQxeeLeZCNbiV8ZDN
         ettidOOn2WjeUeGEoFTxmjWGUvJIafneYKn4gVIHd9i01jtTddMly1mbnhMFIlqMORfp
         YxGsI5T3Gz2lwMIY1VFqldrUIsjX+OGEpB2RmeignNsRHlb2Doa2vzvJXCRgqvKfVMOC
         bPPw==
X-Forwarded-Encrypted: i=1; AJvYcCWARz2G+MU5d9G2CUZ1h8vy5BR5u+PrmS9lk7/5Qi3PS2iYHCtA0bvS0AdoVOS4hYSdiL67JSEk+OOKc48=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMqvCVoYxZZPB4eR7s0/c6dqYafE2ScbSgBWSV/WfE6f7y2E6f
	hAJP1tHhPxfVbf7HShD/VuxhmE2oabRJTemCSpmkUCTp1u26t+7V
X-Gm-Gg: ASbGncvHKyqYzJ1y5yPvcQSRiQB5CFKLEI5zRCKOwNKAsFkcElVHU0zPjNB/UR43y2M
	RUCO1o9ZdBjjZKOOgVDFRoyRkHpvP9/y/PXA9kIw3g9JGhxo/DiQyo4ZqkrC8cUhvq/yMUGg0l5
	smq5jIdPc2Xu8rVxHMees/Q3sICjQ0vfZpb2DpCSY+kv0q3Mg40QUjNQBONDPyOZTh8dLDZm2VV
	2YSYfehN3+9jsdjfFJkDKbnHPfUaU8m2VWdmjcg6DJQbmG8I1k7DjfvemEeTr9q3rdXk9j4QS3c
	Xjm6FAM4yu8F9PSKmH5oLtJKduhogg==
X-Google-Smtp-Source: AGHT+IEIIrPoJh1GXWlfdX3/QWjWvj2/h7CMhTzjWUDIMndNQJ5On8mQEgeMF8lUXxA39smV+RBsqw==
X-Received: by 2002:a17:902:ce8d:b0:215:385e:921c with SMTP id d9443c01a7336-21892a7a2d9mr152417255ad.51.1734374856981;
        Mon, 16 Dec 2024 10:47:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcb353sm46475315ad.76.2024.12.16.10.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 10:47:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a010366e-b911-43bd-8445-e893e11fa51a@roeck-us.net>
Date: Mon, 16 Dec 2024 10:47:34 -0800
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
Subject: Re: [PATCH v2 3/4] dt-bindings: hwmon: intel,crps185: Add to trivial
To: Ninad Palsule <ninad@linux.ibm.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, eajames@linux.ibm.com, jdelvare@suse.com,
 corbet@lwn.net, joel@jms.id.au, andrew@codeconstruct.com.au,
 Delphine_CC_Chiu@Wiwynn.com, broonie@kernel.org, peteryin.openbmc@gmail.com,
 noahwang.wang@outlook.com, naresh.solanki@9elements.com, lukas@wunner.de,
 jbrunet@baylibre.com, patrick.rudolph@9elements.com,
 gregkh@linuxfoundation.org, peterz@infradead.org, pbiel7@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-i2c@vger.kernel.org
References: <20241216175044.4144442-1-ninad@linux.ibm.com>
 <20241216175044.4144442-4-ninad@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241216175044.4144442-4-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 09:50, Ninad Palsule wrote:
> Add INTEL Common Redundant Power Supply Versions crps185 bindings as
> trivial. It is trivial because only compatibility string is required in
> the device tree to load this driver.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Krzysztof had Acked this patch. I don't immediately see why you dropped it.
Am I missing something ?

Guenter

> ---
>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 73a49d50c4ef..7d07b08b1459 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -151,6 +151,8 @@ properties:
>             - injoinic,ip5306
>               # Inspur Power System power supply unit version 1
>             - inspur,ipsps1
> +            # Intel common redudant power supply crps185
> +          - intel,crps185
>               # Intersil ISL29028 Ambient Light and Proximity Sensor
>             - isil,isl29028
>               # Intersil ISL29030 Ambient Light and Proximity Sensor


