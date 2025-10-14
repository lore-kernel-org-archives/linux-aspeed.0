Return-Path: <linux-aspeed+bounces-2431-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4F9CCD184
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 03:20:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clzx60GWpz3cYg;
	Tue, 14 Oct 2025 14:20:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760412009;
	cv=none; b=dTG7TG6OIKaxbwY4TCoULwJxeTT6Ida/egKHh9jOJKs2e5ZR+3nTI3IkD5666m0ur+gusEbozrY0iUI3p62BT5ixPynsesGVrpZJp225MVLD3foiAPkI+7C8sVWxTYqsD/8o+NDGTFmzH7jQW8JPMDAHRKNzxX0H6MBS72BdkwqQom/GJCJokwiKRvaJUpnGHQXeiZIXfd2pNLx+y027TInUeszXySmxpayK1Lby13YWARiWjPOSUgTku6YvrWdyUdMoNhsTbEpYSCyOA0qRwsK5iRaPGT16SIO56cVzWP/oza80k00tWFo+iqeAYJ4pixv8y4MbXAOX/r+Yr5TU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760412009; c=relaxed/relaxed;
	bh=l6UJfRMC7vI8XJ/lVMtg2P/k+rG1cg8dROQofj14ZQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FboCvmyXXPQBYvbiu0Kpg84e5HlNTHcXa1SUmnuQNkNni7+ExKmw0GbIrYSmEQqeutIoDok2i6CE2zuoK78BkguxiOfakYAMnJUWRA2QS98/so/dK2oBYsJnN817ZdV/urpKWeQ/BZSxn19oN/xM6NUEKMp279i/TlwXQkXulyYAgqxGaQTLRfNoPqCcielx4MmGDrkv6n9e+6yt+AXM6x5Bf3IcJJ7G/vl5qgKB/XIW7j9dWx3rg3S+n34BwlqtvUufWPSx3LyDyr6tbvQ0Ae/PXPw1RqH8346zM2oUaNLiWNF6ofjbBSuimkPeHA/nX2JBAPdpiXMETsyhdgEhqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EA587Bbn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EA587Bbn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clzx42hplz2yr9
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 14:20:07 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-793021f348fso4407712b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Oct 2025 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760412005; x=1761016805; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=l6UJfRMC7vI8XJ/lVMtg2P/k+rG1cg8dROQofj14ZQo=;
        b=EA587Bbn46Tl8keRsJziKN93bDpfd2p9I8cywYFjY/OmqRSg+F7Mwnbcpd7/lE59x3
         YW+Pap8O/M1snD+x/r5h9VQfQD6JuOk7Ulvc62JdQcLZ2TbXwIMQ/5ZkXmJ+URe+bSOR
         ALAPsLq9hT/5LpCHEs44Hab4tFnx8CbYJmix6hZu6+9k5WfvVpUn0CElsxixEGzQjV2a
         sxPIBcNy3QlauWa+/x4u5DIQsylDw3nYJrqmy5AJ5Slr8zoD0KvpdaKkaVXUXAJhv4hk
         ASVKXteq5A4G/MT7uY1J03u4dPOt04+042v1+E0lSyovXoNwucwEDDIqpHa8CzZ4TcHY
         ITsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760412005; x=1761016805;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6UJfRMC7vI8XJ/lVMtg2P/k+rG1cg8dROQofj14ZQo=;
        b=g/iXShwdPlmRdRtZWjPTfJxTXD22oS1mPJ2BospRFFtP20KXifyiKfklrUy1QM+sTh
         Co41GbFAoV0u1ncImznjmW1roVSZhV0GErCZcHvJEJGHONTxwfrA6gEDsYpiZTimj4qh
         wN9TOrWe7EoGrOl7AFgHmJ4v/YNUPJSwG2/d0WB48WyhI4qTpjnl8cGLQmqHaOJQeaYe
         g405+pin9g/try8wjZ7lZMy5oCD/hO2V0EMoFXiCOLJM2A8umccP4HHipMIRxl9UcZLL
         /Ir/RTYjQFl3HoI/+9TRcbq+GK67JUM8q9PVu3UKmDTqsG707yi7h4gpJYW4QfBdB3G5
         5dWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ffiRzXknyZE9MPJ0co1ola9lEi33gupnnFCECZGfMt3DM8Oq94XAPP7kiqME7KzIwZjvR+P+HxbactA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJHp9zd+Gz3tXNkqIwXL2HNKGQbSZOMi5puu8cs8LOb557zzTg
	DFbHyaZccShtUwSV77DIi4NlgR2NzzUJcNA8NCf+2sYRfwBIDNFKAELX
X-Gm-Gg: ASbGncu+OhJ+WzzDYmmUXXtXSpAAexAJIxgWNJLjrr+RRtx793xc3YkMDnTW9AXzjQz
	J0sEH3XP+9pl5bpRM31wtc3FysBJBNItyHOw3SO76s8LymgQ2RK/5EnlsSiuc20otNPn5IGAVe9
	zf3NllTkRQ9Fn+TFPY0+pWi5uIAoLQJEyXTnHgnQpWrnDozRX6wTq3aVWNa6hTSGU/7pzhHKhZO
	3JZynoFGku6YCu3l7HAt6jEP84fjBGoRXOvCjoAXtumDjuUv/2ZUX3LIemGiZKC/923b2+7T8jA
	Q8S/FPCtCnvYh2aOJihotcgx3674R+rlZfGhwGYJR842qwPSyy9exA3ahxEBROmg1ooKEWMT+Td
	FlaXTlP51jpWkYSUmNDVmkMSl33fDWMa5LYpH3gjZkdzyoY2d3VYWpl+aS6WQPPQY4Io3W8LyGe
	wepPd1zZYDJPMzkL5Bl85Itw6t
X-Google-Smtp-Source: AGHT+IE2bL3FW7iscYvEusgSbZQ3EznMhjFPvP3ZLjEF/s4fklES93VBIW8vBAnhYEqbAtzcszCZqQ==
X-Received: by 2002:a05:6a00:b84:b0:781:1481:897d with SMTP id d2e1a72fcca58-7938763169cmr30189229b3a.17.1760412004876;
        Mon, 13 Oct 2025 20:20:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b73334asm13266281b3a.21.2025.10.13.20.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 20:20:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e3dc7aee-c8af-4276-84e5-0f0c7926be05@roeck-us.net>
Date: Mon, 13 Oct 2025 20:20:02 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aO2kLyxGlGt12sKD@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 18:15, Tao Ren wrote:
> Hi Guenter,
> 
> On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
>>> From: Tao Ren <rentao.bupt@gmail.com>
>>>
>>> Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
>>> duplicated code.
>>>
>>> Fuji-data64 and Fuji are identical except the BMC flash layout.
>>>
>>> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>>
>> With this patch in the mainline kernel, the Ethernet interface I use for
>> testing does not come online when loading fuji-bmc in qemu.
>>
>> Reverting this patch fixes the problem.
>>
>> Looking into this patch,
>>
>>> -
>>> -#include <dt-bindings/leds/common.h>
>>> -#include "ast2600-facebook-netbmc-common.dtsi"
>>> +#include "aspeed-bmc-facebook-fuji-data64.dts"
>>>   
>> ...
>>> -&mac3 {
>>> -	status = "okay";
>>> -	phy-mode = "rgmii";
>>> -	phy-handle = <&ethphy3>;
>>> -	pinctrl-names = "default";
>>> -	pinctrl-0 = <&pinctrl_rgmii4_default>;
>>> -};
>>
>> I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
>> interface is now disabled. Adding it back in fixes the problem.
>> Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
>>
>> Was the interface disabled on purpose ?
>>
>> Thanks,
>> Guenter
> 
> The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
> feedback, because the rgmii setting is incorrect.
> 
> I was planning to add mac3 back as soon as rgmii support is properly
> handled in aspeed mac driver, but kindly let me know if you have other
> suggestions.
> 

All I can say is that it worked just fine with the qemu emulation,
and that it is broken now. Since it was broken on purpose I guess I'll
have to find a workaround or stop testing network interfaces with
that emulation entirely.

Guenter


