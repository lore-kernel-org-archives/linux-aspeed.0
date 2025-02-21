Return-Path: <linux-aspeed+bounces-802-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89574C021AA
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Feb 2025 08:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yzk4P1Jvqz30Qk;
	Fri, 21 Feb 2025 19:36:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740126981;
	cv=none; b=QkBoXxvR6hRiW7NN1I/TyvDNY2mQDPCnyeAKXuRwuTwigaknPgqvifAZcJAV+ZrY7VcfaTMxQ3REVZ+DgJldPsPkPIigdLBhnHpktkjxZC08Wijx+X65DL2WzK3J3uIEanoxMzE/5aCQ9npS6IrB6RXysx57BNvG3oAWR3SBJeEnhBDyXVKgNrsurBmvLNBU6OvBkvXO314GfoZNMZ+dAJxWYmQimus5GV3GZdVhSXZBj0xu+4vzqBb2UVMpOV9qp+7Shz92oKdqejvXRdIwTo2fe5oUqEKdf3QqvF5qXue4O8tJ43I4IiTyWqDkU9hiCd3FlXuVHKPKhucKnHs9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740126981; c=relaxed/relaxed;
	bh=QKL8Ay+wgKZPnwjJZqrrXxULzTRfOvNphhjWatjKPCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YDh3Q4b0X6vtTp7nwtp9CZYaHvm86Q1urbND0RbXeRH3KVStUiX31BUGbD/5OaGFs0PiCadouNHWbg/a78Oc59hDaGSGmCuTN6XICMTNbZ5FGLW8sVKJhK5gLh9Qhnc6smC5FMvukPvlxhEDjyGPTGnnvQCAetCf96nKKFj1fnPA4Bu290H0DmgZnnW0JQVfW2a0RGMtDkkUiAkTBJFf9zRdNKMl5nP6DJ3IibKzwZUKbnx/Loxb2RV7ryCBe3PeA0f28KY/zHjxe2KR0t/PQmL3hJLaG84ooy7EsY769cA8JLYR2k3QSkU09j+evkS6es6vZ4Cg2Ernlf50IDkLBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l7FQePIy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l7FQePIy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yzk4M5m6rz2xSC
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 19:36:18 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5dbf65c0c4fso339351a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 00:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740126975; x=1740731775; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKL8Ay+wgKZPnwjJZqrrXxULzTRfOvNphhjWatjKPCg=;
        b=l7FQePIyQ085XrP3vqzFAwl3tu5dmzT15vunEFh4/bOAeDYD+D6mHaCUrp/hb/4psC
         McXHGdXbYUp0iuKWzpld20pKET6VTMMg+0DLCJZfLKzEaPOc5P7I3KpOuKf3ZcDOhCEU
         kHPxY8qtxPeqlAb7QYH4tyztA2gibD6cEByg7JzKDwyj/RJvF9qL7lI25fj7WcaTharA
         Yg8zfahiQMl52n+pRv6B1hrVE0mjBG0g0J0BVql8ysgiYrIoQan4Z/PsoBkt46EQV+K5
         jE1uzQKgPli9J66qbWAezQThWSr3GEFc1ayNvdHljtKFI5WfN3huI5rq8BAENq17px7K
         T3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740126975; x=1740731775;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKL8Ay+wgKZPnwjJZqrrXxULzTRfOvNphhjWatjKPCg=;
        b=OaORDT2tRaDwFlkmygAYO2B4VA5rXrDScOF9RWX+JxP2Ibeq0lyrkfXCD8BKtEh4Du
         aCeNpQjdnuK+1CtHt1h3of3S53RF6koQDaVnqCsJycYpa4IP1+EiG+muQMehesqVk2rq
         0R9nm/WLsfLDCGER0cyHcTkKOCA0QQqfzguIuKNCnwiLDvId3BMFdKTi/9d7DsIAeqan
         BlA5VaQId29p3wBQJrrrWY4fWW/1scZOZJ/1MpJNYLz5u0BYQ9ScnMbYsWTS+OkwEmo7
         d8+ZRFbtNIHbM57PVTPWnmOH7SdsC9TjN48YXjeonJSepMDUbz1nyED3csOvitpNTpr3
         t6jg==
X-Forwarded-Encrypted: i=1; AJvYcCU47Z2Qzc5iwK/3unPw2mfMjp4v6VnVIFzPrTvXVOIGuuoiSk5uVFay9l1RoAXQMy+kBgDV3XDvOmFBgTQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy4WUkySA5Ld88DAmOV8VE56IjT3fCz4HF7aXesZs/1NZWvpI5Z
	eotnrmhkiTNELoEJARnZxL+OQT2lR+hJiVbFgubgez880LyCrZNnsKf9IfdAAZU=
X-Gm-Gg: ASbGncv2rdZFMmbckDnr54Y5HXcL/RQqU6kky9r87iNCS1xUIIaL+RTw1vAZyKqgI2o
	LHE8bMUL3Q2zaAmktP0B/DkoCVW6WSnzGwZ2mv8he+54jf6DafAUdx8Mw3Hb5KegyJ++kaoL2E1
	cHivYWQwnz88qIcZsnybuyXM0Tzp14RIomgr7Pvrd6ePCsBZS/TpNmP4VCWZ1qHR6D01lw5Mr96
	pYufskAJSGAfySfRBsaoUUeJQP4tEG0uW0vtisAxyfn2G7oymc/N5tqMVZ2LIWWxWRTsuZXDiVV
	qwqY78dmvGO9Ugih3VYzqsIxzY6fuvrVwJRA4dlP94535OEnrKNHLrq3ppTq+AYNSvmtdv+eLyl
	uX1xn
X-Google-Smtp-Source: AGHT+IHhMeTPzc9o8Mc3A4pZdz/U1wryY1ec8xOhVWr4LxFvamT5fLAo0iBOuCyeUhsvP1eG63wRew==
X-Received: by 2002:a17:907:7f9e:b0:abb:e7b0:5437 with SMTP id a640c23a62f3a-abc096c807fmr90322566b.0.1740126975506;
        Fri, 21 Feb 2025 00:36:15 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb6e4df5basm1236889766b.152.2025.02.21.00.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 00:36:14 -0800 (PST)
Message-ID: <938c66cf-5be4-4b14-bc1b-8b9f7afaf290@linaro.org>
Date: Fri, 21 Feb 2025 09:36:13 +0100
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
Subject: Re: [PATCH v15 1/3] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 "brendan.higgins@linux.dev" <brendan.higgins@linux.dev>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241007035235.2254138-1-ryan_chen@aspeedtech.com>
 <20241007035235.2254138-2-ryan_chen@aspeedtech.com>
 <SI6PR06MB7535BFD3377505F5191AED7FF2C72@SI6PR06MB7535.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SI6PR06MB7535BFD3377505F5191AED7FF2C72@SI6PR06MB7535.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2025 09:25, Ryan Chen wrote:
> Hello Krzysztof,
> 	I am going to submit v16, and will update the yaml file, in my this version will add aspeed,enable-byte.
> 	So, we should I do about this patch about " Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>" 
> 	Should I remove it ? or I should keep this Reviewed-by?

If you add a new property, then please drop the review tag.


Best regards,
Krzysztof

