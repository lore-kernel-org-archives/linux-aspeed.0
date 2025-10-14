Return-Path: <linux-aspeed+bounces-2442-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E97CCD193
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 16:39:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmKg05H95z305S;
	Wed, 15 Oct 2025 03:39:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760459948;
	cv=none; b=WaQidBfFjAAts/oHKgDaZLLLsF6ZhwuIGsxuZSh832J4d/53+dbHpOrgECEr41H8puydSf3ZTY7D+QxGumFwpqfHILvBH5WwLGKyw27hexs3PdB7dwCa4Yxx3BVSxszo1cLc4z+VLphgA6PSrRxs87bSRBbvhvES/uF6RkHN9rQORDHTzPDwq+qb/C4cr4RC/yYZxmxK4mu/6HiwTXeBU28r9g7YN/L2x/5ROwHhkZu48LQcQJBfoqmLJGnLn2HvUITQ+3IYTfCLy2EY8YJIC+pWdBBBoZHNUkWIS8kFReYJVwh6AxZEpThubU8tyHOMOX2uygRiA9owrhfpClVTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760459948; c=relaxed/relaxed;
	bh=+Kw4a2cbpYi6EVcibNkVqQEvI9GFueOoA0ipAsI1iyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zwt2pzbCbiLOv7rxr4B/IrzoJF4mWchWl0bnmvpTjEr1bhY0QTRMbnSb3gdVk8gH126Mkvi2ypbJh1cQ/h9Kv2GYzA7h3IY+g09Pb/pwvzmUx0CeXmBCDwhJlF5i/DGO1mAEUmZONzhfF5xR99gPgpp6gKocVrAnctcdVjkTRvq42iSXnrLL/RNqYMpWvlfuEPDiiTlkTRfvp2F9r/WTnmdjCrfyz7Nf3NrBtDpZIXKDz7x8fC1gJWQutHD1Iqngum1MtNLyfRY0qWSvcuNbcLqnl9gjdrdzbJp67hy7DvbbKqHgeNcxbTmiDPQ+n1+n2LVlwm8Le6YSjqivA7uUrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bcz8yndy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bcz8yndy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmKfz0M6vz3020
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 03:39:06 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so6839612a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760459944; x=1761064744; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kw4a2cbpYi6EVcibNkVqQEvI9GFueOoA0ipAsI1iyI=;
        b=bcz8yndyxsfkmQvmHCXqIacffbCk6fDWO6FYXNJE158U3yTErl3t65ttCxVR8VTWZa
         +pt0DMzR5ynAP3BbkDsCDvYHXEZatPMd2gircOuujxz1sn55Y+gXMttX8WdEYvpAT8GK
         fRHcd0jNcM//E/PBF7G5P3+lgiUg2UWQ568WWyL2WWqlc6BpKcPfSg1jS4pzL7wT8HXc
         pZsN7MiZYGqzLIH7P7LcN3GXJhncZ4/NIya1CTNUOlGqq3xPoRiJ1oDaBlLevJYiYjpU
         OFz+D2yG/ebl6MqEL1CNlg36JcSL6Q6faoQ27k43cy+Ei8ewQouqakgf87swOlcrI8e4
         QzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760459944; x=1761064744;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kw4a2cbpYi6EVcibNkVqQEvI9GFueOoA0ipAsI1iyI=;
        b=hc3FjTPqxrSxm4S36AP/DHRtIRE8tw71EzvtVnwMG2tlmrQ6ulgU8ynPWfEV6Pr6pq
         CYxpvf8KHoI1uJGSp6a/4mKKh6Eh/WQVmmwQlooGk0Qgj5ml2lWIXGdivmwDyoDucypO
         XH1OG+z6vyzOtwGHkEzfuvO10wuyAUtC5jZntYRNn09ejiQTG+sstfex1ZVW5DpM7XJ5
         YuH6npgQ6ht6AtTXJY6s+8pdLMcKtrZSJT+VZ7oPmNk2ZIWH80Y52nnL6thPDbF6lrj8
         T7ZBmtiWAoB/+RxH6Iy1GxQo/ZT5wSUqvpaLBqJuCgvGD/px4Hl5n+EIbUsSGfSnrDnd
         hxmw==
X-Forwarded-Encrypted: i=1; AJvYcCWGpL51geT6l8AvbWpH06sE8nM/u3jZL171xQMIKNy7SdZjB+2d+fIcdcbug0+BVXWX7Zvxx4D0bb3LuOg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzC5Ov/3Ldtq1dZNM4hZUb+psia+rybSD5+qJVBrqXOaA1NPXDC
	/unBWuoh5r54E7TddYgGyHhL0OTnnpxBui7GKS36Clc7+tPTJrLJ2ceC
X-Gm-Gg: ASbGncs9L9FQwouvxgfqu4Y5CawFQC0oghxz4U9cZVeJEpzTnKZ5mQSgY3zD8FNvQ3K
	dAWSwLryt3M10jLWpg5WAvHWD3dYCdZABSFXPmniOVk2K6NxjMbqebbNxNpYWJ5BkvwYcvdXXd+
	GduBN3HKdZ7Zxl/Z1m9ENEwqUeEK9/cH9J1Tmm13g0T0W0WVyidihWLWSb4tj8KO9KskiHdcBE6
	zFz03BFt7Ydbh9eWHnRtcQbM7jmmiiBMOxtf1ZJphOX+sHvw9ix2qazGuc+pPcUuuajNk+1RAtA
	ijNSobq2HiexR6KcH0CCl7ZOoWlz4KGFpof4Rjli7lAAaq3C7XLiu20cvnMe8uomR0QIse2Ufuz
	dr/ZzK2G39nObkIZKb1ZCzZ7O9SyRPTAtA5SgvsZUbPqm87lqviV4pmtesZOgCS5oqGMC634j1V
	FJTw2hCJUtJe1waA==
X-Google-Smtp-Source: AGHT+IE7dkO7t7zYTrn/rcvOU6CyaOeoWX3R6oaYLqTk74O3/dlsNAXvmuhzWnV7MaYaIVUdZmkXFg==
X-Received: by 2002:a17:90b:3d12:b0:33b:6612:67e1 with SMTP id 98e67ed59e1d1-33b661271aemr20674579a91.29.1760459944049;
        Tue, 14 Oct 2025 09:39:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df6a95esm12321716a12.36.2025.10.14.09.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:39:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>
Date: Tue, 14 Oct 2025 09:39:02 -0700
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tao Ren <rentao.bupt@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tao Ren <taoren@meta.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net> <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
 <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 08:11, Andrew Lunn wrote:
>>> If it is already in mainline, i don't care too much if it is wrong. We
>>> don't want to cause regressions.
>>>
>>> I only object when adding new nodes which are wrong. If we keep adding
>>> broken nodes, there is no incentive to fix the broken driver to do the
>>
>> This wasn't adding an allegedly (sorry, it worked for me) broken node,
>> it was removing one that worked for me all along. Obviously I do not know
>> if it worked (or if it is even used) on real hardware, but it worked for
>> the fuji-bmc qemu emulation.
> 
> It probably does work on real hardware, because it is one of those
> "two wrongs makes a right" cases. So i see this as a regression. The
> node should not be removed. It should hopefully get corrected sometime
> in the future when somebody actually fixes the aspeed driver, and
> fixes both wrongs.

So you are trying to force the issue by disabling the Ethernet interface
on fuji-bmc until the problem in the driver (whatever it is) has been fixed ?
That just seems odd.

Never mind, this is not my hardware. I just used it for testing, after all.
Again, I already dropped network interface testing on that emulation,
so for me the issue is closed.

Guenter


