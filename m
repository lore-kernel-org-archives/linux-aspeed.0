Return-Path: <linux-aspeed+bounces-79-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5FDD2B941
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Nov 2024 15:47:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XjXlz17bCz2yYd;
	Wed,  6 Nov 2024 02:47:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730821663;
	cv=none; b=PNvUhiUyyYsgBDXO88225LcjkQSM8AxW7WQqJA2dicTUvAn1yMnkd5CP40g5sQSjJGISswqgey0Iz3eDYQwCAmNJ56AwNButM2iJbTnQDF+fCz8T0bIxqPClviiD6RAJfdp71uAOi+M0DnwPSWqOecTpTEJs1p1tEjro2c+QaYDlGEBX0CG3eOG9b7sG5qlFetGWjV6B8aN7mlxtdAocL/c51Zi7pJAXdC0KygYt+3t9V58PEHEDJl4VSDIsjeEjwmzxMniS1eRSbtpRQBfYhnNzU1R3nRAvsRF2CYcdae7bPYow8IElmw1LKvb6/sPIMEtYB3WtuN35uVD3laMY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730821663; c=relaxed/relaxed;
	bh=1ooJDnnYNEbk1kr2lCujUoyFBk6F58+aUycb1FL/7jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdBVYR4H+u8Z6Y0vUnml2pzrsQTOYAgg3AJLoBYOMm27CqfjSkKoMOPE9qJ6574FiPbYx6Qam1UCha3V9XdET5YyZWDHA3Jm4B+ZjYdSVamSbLaAljQX6V9hkjVfsPXEc4cqZprk9aqxawNGp2pRnMA9UCtGYy60uy27UYKZbpI3hWONJVrMVFsctE+Lf3XQmDPuFMmat1aarVf44/G3Tj+FQyncumbDAyBXFY1WS44Axn9mhmcx5wxXXpJq5iM4Nf0axmcoAT2T5xaUVKDQM8vdHuT0sxhtURcYbJ4BnGOh5H3MwHQOqkyIQsz+DuWHkFmxrs+vvqzC3LXgNfN5JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a4BcRmlh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a4BcRmlh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XjXlw52F1z2yY9
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Nov 2024 02:47:38 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2113da91b53so20756835ad.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 05 Nov 2024 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730821656; x=1731426456; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1ooJDnnYNEbk1kr2lCujUoyFBk6F58+aUycb1FL/7jA=;
        b=a4BcRmlh3+xDXMS92vcSjKYOtpWWS9rhvOxWPcwSssBtPGExGxjgAIutDUjg40dChw
         YNQ42ivtRLaVOB1XzsrgRmXDnSIZ0xzgcegXucRawE+mPkIZzYvrk5cWjReWzDxA2KTg
         V5VuWKKMetNf66ndvE31R0Jx8C9Pw3v3w5qCom9s9ixfcFJ2Bi93Nc08ZVLlRaQPIyrE
         5KvP+h043/gEALoTyMFGO2agAte1bpr2IVtmyTjJZlOA5g2DjbIe7id17DZTAEq8GBZE
         3j95LM8zcP6fJp/StZmS/gYQ298FfuyiydINH/ts4YCdNCQ77mGk9fES0Ectu/D3dZeF
         b4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730821656; x=1731426456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ooJDnnYNEbk1kr2lCujUoyFBk6F58+aUycb1FL/7jA=;
        b=AivIbf/K7+4LLBr43BVVfRezL/XQtJqMPDuSP21H4VGaIxS93T+/Yke+B4TaUfCErV
         rvUwsIK7MVEpTE6jYeRCzZyNG+eU81U5dOYYkWMAamyKYToHNJYH804TRyR2d8oVKzvk
         xLPjJKlREJfL5P8vzM3sGE2dWMkrb59c864oKvy/ur1Dvxy6Ky2LEcI/7Af+JXgX7nMD
         EYDQVaWRN5hcmq1CFIxyxk5tc1aw6zGV9yJXvFWkvW/0QVVkWQY1D7rEyceS3iET7L2I
         zdluZ9dDHd1wv95Ur6kWV+z9ygUwR/Q7VPh006hLeSmVZG9m2gUEdOmORgdvyGVpTCO4
         VAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbBNV4SWwW0ksjY9VeOEkW1v5+noAU48/Cs+eOyfS1lWRvhmxtJwQREb+3+bqHLoUvQyCnvqdKNpyHaOE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YynkUGGNhR0KiIron3+H2XUdnLgYJuniANQe3Z94Ra+oi+ZGJnn
	Ng5lq4m7xW4NTNQZXuXZUP3Qa5I+CLxXXPrebBpx65bRMUpODJ1cC7KfKw==
X-Google-Smtp-Source: AGHT+IF9zcbwT3e7cLCiI/zQ31Uv++mbdyvSf96625AcWV9rKF0bSrU3s/WqP8Rl91+BbmZJqznG6A==
X-Received: by 2002:a17:903:2445:b0:20c:bcd8:5ccb with SMTP id d9443c01a7336-210c6c0610amr518053055ad.30.1730821655815;
        Tue, 05 Nov 2024 07:47:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2b83sm79133375ad.157.2024.11.05.07.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:47:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
Date: Tue, 5 Nov 2024 07:47:33 -0800
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
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com,
 sylv@sylv.io, linux-hwmon@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
 <20241104092220.2268805-2-naresh.solanki@9elements.com>
 <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
 <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 20:10, Naresh Solanki wrote:
[ ... ]

>>  From a spot check, the warnings seem legitimate. Did you send the right
>> patches?
> Just checked again. They are resolved. But I guess the dtbinding patch
> for the above warning are merged in hwmon-next branch & not in dt/next
> 

Did I apply some patches which should have been applied elsewhere ?

If so, please let me know, and I'll drop them.

Guenter


