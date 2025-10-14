Return-Path: <linux-aspeed+bounces-2432-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28C6CCD187
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 03:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cm0T21S3Nz2yr9;
	Tue, 14 Oct 2025 14:44:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760413462;
	cv=none; b=Zg8PmpR7jufpSJdUTGS9+zqyoK+XDpvPF1i5VrHoCf0Dq2E3BIx4hqc6V6PAe/pRkj49VUJd6j7gWOpS71KSj/AF+CXOEHBYRKZmMxc/D5oh02Hrom+n+IkwgOEQtRCN0EiHnkGr9sE1w7ZvjqtfLgs/lyG6qSe+mUMTTNpcRrVQissR3xX8axb4ZTwkdHGV4BndAdsydxChvknGdTdxX8/6/NVEz8S/fGXE9+Osa2J8/lM4+3+UaZiev57rAzLIrTbsReHyv69SVU6zhtJcHgCoM2iSkksdU/fBBSps6owD/biV2icRvwP1c3zj7kMbZqNyFmOMiAVhbnKOhB6htQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760413462; c=relaxed/relaxed;
	bh=h2hE9dVU4dDBKSr5RQ6ulWC8RhSPxx36Nra/5fv0QXM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z9fmlcWzCvvXiJ+1+JordoSAvlNqME4KoXj/r1bzNRvwaFKmeDWEc6CJad8m/38emMP+sXhQQG2ty9oYGDpFLBR13s/hudv49KzzaBnZHW7r5D8ep34d4sBgJxsgMPWj5w7+XWdmyPTHAqE2gtW4ZiuyHXqoqqKtfeDljX+qCp5BGIVLMDpYdmaW7GT38Oo2HhGntv+vs+mIxqXye2HZfJP1elRQW4+BfF9ot9L2oNwe6pE3qLm8CQDcQhllUS10JqJKGh5PAV4TcRgIH1n9ugn5WnCWM7tIMztG5L+mJ9kyQbSopeVtNLcC+vTu39k80jQk+cHFKlNgS/AZamcP6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m7x98AuU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m7x98AuU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cm0T13R5Tz2xQ0
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 14:44:20 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-27d3540a43fso45682075ad.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Oct 2025 20:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760413459; x=1761018259; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=h2hE9dVU4dDBKSr5RQ6ulWC8RhSPxx36Nra/5fv0QXM=;
        b=m7x98AuUq0bDliC/0xiieuDL2CQMl0GMxc9TTlYQ4I2Wtki3n4d782ybEcF9PZjIQL
         4qNRi6HMjLd06Y8FJNIkuO+whyfP7HMptWrqPiv9oMKvmjmkKWtBBB0chYDe2royrzs3
         tY7GEjSwXRatoQQXEVXGZXbCiEE84J1JR5LLx/lbFHWktog2r+JRcHg/yyNmqsL1Pa+q
         c7Qo++UsNL0mL8B55Xiep+DJN6boYRZ9TXcg6p72yC/mfiQjWU95dyYoN0coKmgHMaiM
         kuqqpSYSOIv7vTpwBWZI/VvKYgcOzHRfxsrUO4NBGscXu8Fj+uBW+nRDI2I00vdFnUjF
         AfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760413459; x=1761018259;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2hE9dVU4dDBKSr5RQ6ulWC8RhSPxx36Nra/5fv0QXM=;
        b=J+yMZ61kk0CUP4DGPCZPXhIGFPSayrNLrge9CotlgXO6t07g+EPcUuTaooTufJgxbV
         kPgwb0PZE9M8Giv20I2ZFE1jWXgmLR5XPiisDvt/o9DUNMWdDO23eZVy1QQFTpTMX8Ci
         pA1a52Zy6dSpa9Drm5g9F/72xIVnISPaAMa4avzgwiYedgI93950BPI0Q0F2Cq0fCpA5
         2x+bMgbVrB61H8IZXqCBWcT0h/14+mNiOhKfOZcgBXBUormjVfMFVfVFzy7tfRbk2jka
         dz5mRCPLyeoXFxsutVffDSBvcB0mNneLD64XrRgGtgvM/Hv5Mi6SWHvNU/PlptGpG9I3
         6Suw==
X-Forwarded-Encrypted: i=1; AJvYcCUWYpbSmj0lIC0bJOyf4imRCLrd6KjxthsqRG97nXzByZH+zzYSUXOJItl1sTJvtoWmdR2qtpgE6V35gzA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyliBU0TpCtnH9lZ+LPwlAOnM7VZ6bJ68p2SQInniuhvKIiBU8X
	aypFbV0JP92LNmnFL70LOl5GIPGtISxMNc1LwCyVpP3pqn4iL6fnTYw2
X-Gm-Gg: ASbGncsKeQ/Jer8VnMr2kYqBZnHjARa9uoBHGcPdxQONONDoSfxoZo9aamprV7YcV+y
	2G+hQeEZ0DthWX1QIpSCdLHLxiCQ82ISXRWZiZC5aPEnr21uPWJQMoDAwWOU4ZB9nBTTXzrIJ1B
	hvLuT6gh5W8t6FA7reDN/LvA8bungLgbDiUzRKPNTejNfIkJsEeglfCYT/At+HD8m8rgH2aD/Ki
	EaA1Q8PIH/uW1Somtujw9Xd9co9hWAo5UT3MNSZDd306kE6M/Y3XMcEfaR5x2jt9449Y0zzmBaX
	/te8mK4HI71soKLMxpVpD5bPb17CK8CutCzet6WxPSxrN4xVAFrJhSAOWVPybHeC2HKBsVuMkat
	QsXkmoVIsvxpPGxhm23xrvoDoqzszzR/Exc2QI0qGofskgZQgFujHKaT4jsAXa9xegNdfMth7qT
	DP/4ldvI/BeMOpZg==
X-Google-Smtp-Source: AGHT+IEZhWXWpwus8ChUcDCamrlYbdhxVRgqmS7EMLMZ6ANGP8vAcpE08Mz2FQZlW0+Zvn5ycGBKFg==
X-Received: by 2002:a17:903:19e8:b0:28e:ccd7:dd61 with SMTP id d9443c01a7336-29027305380mr282716995ad.57.1760413458712;
        Mon, 13 Oct 2025 20:44:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f961c5sm148224085ad.129.2025.10.13.20.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 20:44:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <054cf209-61af-4d21-9a3b-d0f6dd24ee3b@roeck-us.net>
Date: Mon, 13 Oct 2025 20:44:17 -0700
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
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
From: Guenter Roeck <linux@roeck-us.net>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Tao Ren <taoren@meta.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net> <aO2kLyxGlGt12sKD@fedora>
 <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/25 20:20, Guenter Roeck wrote:
> On 10/13/25 18:15, Tao Ren wrote:
>> Hi Guenter,
>>
>> On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
>>>> From: Tao Ren <rentao.bupt@gmail.com>
>>>>
>>>> Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
>>>> duplicated code.
>>>>
>>>> Fuji-data64 and Fuji are identical except the BMC flash layout.
>>>>
>>>> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>>>
>>> With this patch in the mainline kernel, the Ethernet interface I use for
>>> testing does not come online when loading fuji-bmc in qemu.
>>>
>>> Reverting this patch fixes the problem.
>>>
>>> Looking into this patch,
>>>
>>>> -
>>>> -#include <dt-bindings/leds/common.h>
>>>> -#include "ast2600-facebook-netbmc-common.dtsi"
>>>> +#include "aspeed-bmc-facebook-fuji-data64.dts"
>>> ...
>>>> -&mac3 {
>>>> -    status = "okay";
>>>> -    phy-mode = "rgmii";
>>>> -    phy-handle = <&ethphy3>;
>>>> -    pinctrl-names = "default";
>>>> -    pinctrl-0 = <&pinctrl_rgmii4_default>;
>>>> -};
>>>
>>> I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
>>> interface is now disabled. Adding it back in fixes the problem.
>>> Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
>>>
>>> Was the interface disabled on purpose ?
>>>
>>> Thanks,
>>> Guenter
>>
>> The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
>> feedback, because the rgmii setting is incorrect.
>>
>> I was planning to add mac3 back as soon as rgmii support is properly
>> handled in aspeed mac driver, but kindly let me know if you have other
>> suggestions.
>>
> 
> All I can say is that it worked just fine with the qemu emulation,
> and that it is broken now. Since it was broken on purpose I guess I'll
> have to find a workaround or stop testing network interfaces with
> that emulation entirely.
> 

Ah, I see that mac3 was the only enabled Ethernet interface on that system,
so you effectively disabled networking on it.

I don't claim to understand the logic (how can anyone continue to use this bmc
without network interface ?) but I guess it is what it is. I'll stop testing it.

Guenter


