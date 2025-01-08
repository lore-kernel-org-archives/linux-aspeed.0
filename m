Return-Path: <linux-aspeed+bounces-367-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DA1E77199
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 17:16:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSvj214Q2z30VF;
	Thu,  9 Jan 2025 04:16:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736356598;
	cv=none; b=ZKJRfvrGuii/vYi5qjl1RB/l1WYuc1sgbvoMKdf1a55HUaNmNYHH0yhw02ypCrUj/oBgeFOSDBLPQG8lUyACBI6NRs2Y1IG2+xOnFXW/w/LdqVkKW1oTw1dhvP6jLCDzxNdON1ZmfSVtAqIJQkjhNaVP92dWdfDquj+vtV06S339PzcbxRa6TqBCQz19AIrLoOFsqCt4WqDxtOekz9XRQiG0EbAahEK6Pd1SgIJFRrahskfUmIRyluVNgEX0Rw5grh4suWQWBc5UUk2Cvx/5/HEXS05nEx0t/DCJCXYDvUOZbau0vzTg5GnHRl2zbzFSmRSnxm1SjAzcZ5QMb+mT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736356598; c=relaxed/relaxed;
	bh=0T3qTmWNKjRvWAUF4BnhHDw4+Y2/jmnBIbfLY1Le9cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ks/Xgm63QQNzzo2iqQeSih4HhUBMn+lqzAz0gjJNMM30gBCT5/Dsn5RGHWoSdho7C/oAiPTUqINLJgAFFd2y5xARth04i1P0c4HVqPmtz919DS1jD5zj1CBuof4NQmS6qL5WiwYsBGwy8LtX01BQLvKOF5EhhVyaXsuScoK8L/NH+4zm0+wwxnjst7JANzpvdwhwNV1Ff1w6wBSB4hKkqyQm5MHDstUXW9JbgSuW15JCXtc2t8EOVSaNMES6CTl/wKoOKaRZCEFpEOwVKpI5IB/EUZffVJ0nqSREkuG58JKRxH1eUcviXzI5dLABqpTtPpCWxb+NqmrdUHg3qP9FHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OaYErN7X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=florian.fainelli@broadcom.com; receiver=lists.ozlabs.org) smtp.mailfrom=broadcom.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OaYErN7X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=broadcom.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=florian.fainelli@broadcom.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSvj04xnVz30Tk
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 04:16:33 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2167141dfa1so350195ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jan 2025 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736356592; x=1736961392; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0T3qTmWNKjRvWAUF4BnhHDw4+Y2/jmnBIbfLY1Le9cY=;
        b=OaYErN7XXcANrVzsv850CcFvFGoD+kgwfQH4i1GBKk6LvmhKXjg2vpKCEuDcE7LGi3
         QeOSzJiAh6Un8UbQBdqPqRH8Z4vaQy2Z0J9GAO4UuGzQKj68a0RjVvUkc4/uz6pKqHh2
         jlF+ULTO4WmpmLxJev1uXZDl3dmVJRj1+GSK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736356592; x=1736961392;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0T3qTmWNKjRvWAUF4BnhHDw4+Y2/jmnBIbfLY1Le9cY=;
        b=nx069oNlc23UP9z9QwYchVRAbEPC5q+wRoMh8D4DS14pb0+eqncHcnvsCJXw0ewcPy
         eRWrFDxrbpzZM/PpwilWWFTxUsfgnuye/5QEyIlVzxS4EEUycuNIJ2g27SmrqCC71i2n
         la4YmKxZXhMyiuqYzOtTODb478fRFhQBtbvCG4AOCTWvIkn18HugUICmo3hthypIpbYH
         B2tNSOzp/CQgAWtl/ryEUIIQkrfQ0JpgruZbW7Zbm+migNEQKvfhpkeFJrTQje/qIJr0
         QYbSPSYNs6i4gjAdF/gGpSwcKNfaVwy7nl4hdpu18wwfkaH9JmfKgUCCUcmmJuh3RrYS
         niTA==
X-Forwarded-Encrypted: i=1; AJvYcCV6YN47/6BIT03xtCXkxp54F0VwS65qpZ8r2kvCi64L7a6qPrgorLwurdqv8Tn6+ksTbD9DzInz4BZ8tPQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQFbPxrJ0fMuY/SqJ8jE/YCaVbq4x8wvPqEFj6wUE2C+k463XT
	JAdODw2ao3rI1Zg120EKyb19KegBLKCTI0159P0JYKtdz5BHrx+cr1P5xP29Eg==
X-Gm-Gg: ASbGncu22kvIVVgUHttz2lMsPgVTnoD8yE96Dff27hqN6s+07xFuPKopUrff0Ddo6Yo
	npOTvT45G8HQ1galsob+7p6SJLJA3GvdDawk0l+xM9zBz7cqm1/KK2p0ew6F6e+XI81IU6cZyLY
	qBGPpauAt1ExUW7uDzU/oSiAgLkaUr9tZmolV6buhNEYBsEbYaO8bOc4AA8KHmXt4KGhBIq1i9I
	kEIon5ktvxSCs6CsLeFeuBLmuIGvtsFjLFeEttiBMZScQ6HwowlCndWTG7X/p8qaLpCCYq0QN8C
	m+WOjLx3DNQ5sON8DqUg
X-Google-Smtp-Source: AGHT+IFdirgINMAKBimNFsOTtAuNTTf3q6GIEsWAps4SrC0rZhPHcEx1lfpJ6b1zIeyXBLocP9cM9Q==
X-Received: by 2002:a17:902:cf4f:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-21a8d66fd2amr1197475ad.7.1736356591694;
        Wed, 08 Jan 2025 09:16:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f4fbcsm330246845ad.174.2025.01.08.09.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 09:16:30 -0800 (PST)
Message-ID: <06f649f3-823c-44f2-b71a-a6ec4d38f20b@broadcom.com>
Date: Wed, 8 Jan 2025 09:16:29 -0800
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
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Correct indentation
 and style in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
References: <20250107131108.246898-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250107131108.246898-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 05:11, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

