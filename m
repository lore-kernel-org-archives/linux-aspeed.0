Return-Path: <linux-aspeed+bounces-2417-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F641CCD185
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Oct 2025 10:49:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjk4p5Jvrz2ySb;
	Fri, 10 Oct 2025 21:48:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760093338;
	cv=none; b=JuqKFpN+Hbx0eOy94fVVz4Aa1Ht194Y1ns9kqXcybqyiO0BXZEAGFsWIAM9ePLrxSqJ3dXqsWxk+ZXJ+KwuzW7wYZT9M7kOlAqyLcvVyhanwFU/NX0kTqcGQRwbhcTIppP+6fSjceB0cK7JIsuJgdV9MssCt31togH8kxbCKR+q/ThFn2nfXMZAV3v809zfpq3nCaKP3nZrzVYiIOBNQ8ht8jnp9O4Z85d29PCT6PU445sGtR+ONigwQONnLHTKZxnsFGktlRE40YxIcfz/JIWhwNety3T/Ji03B5PGjGMwQAhzu0ya5Sb2YoAI8yI8PhbKeNx16pavc6IeIyc/htw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760093338; c=relaxed/relaxed;
	bh=x2LiN8aGSeEz5/QEAPT2ZIDR5uamXQ8YXQ1ZPBqL/90=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oa85Un7QmirKpVqrhiMjrDry4Uw+MC+aU9rk9N9Pyh6uwkiG6uztAs9L30YHAkRtaQf5+BaO3DqqxtlhJjF4cUPrvTItb4iFo0oU5k4BXgzNLTWHRFb/szU57IH5+owdv7z/WB9YENCtbq7W3+oruarpzT/g6lpkV0dc1tFCAUk131dWRnj0vAVIHjyfNJk6gw0eLB2h2zZroN54VG9u/Jo1ufMyIJuGqwbTMbx3NU0jyqQpREBkdoqX3YKQUQEi3miN9N32clRjZoPks5fAE3j7DGSXCfB4tAR/azb6dXEiCutZcQVsTrQ2sF3sWeUo+q1rUmGHrW3r9mYntkvBBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OEuUKLrs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OEuUKLrs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjk4m6rZJz2xPw
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Oct 2025 21:48:56 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-27eceb38eb1so21013095ad.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Oct 2025 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760093334; x=1760698134; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x2LiN8aGSeEz5/QEAPT2ZIDR5uamXQ8YXQ1ZPBqL/90=;
        b=OEuUKLrsifQWq7102iSNTs5Ns9GByWAFSb3CHwYDRafqdJYZ+b+IlyW53mn9/YgV9n
         h056iHJ1qhrAd0kYaWUOzyMvTplOc3gfnDDvcxvPpfoMaM0kjZ4K4CeHrnEm6G94soXw
         WLmYTMDJbmmgU26M5M1xxPKsVZwdHFNqkFyoCJ+Y3gohcVaTEqTQt153f14o96kGDl+3
         v5j297mcqnzt5OZDQgy8eZP+oK1NNTnvqtQ/Pg+YF/CNTn490gEe/oNqck+wRcOGfbTv
         Lmpjw40pcEeyglJ518m3sdMl3ylJ3vqTxF50u4AiCSxEbqa9MJ8k9XKHkOLSguLqIKGJ
         im6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760093334; x=1760698134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2LiN8aGSeEz5/QEAPT2ZIDR5uamXQ8YXQ1ZPBqL/90=;
        b=mzKCRihc9WwEK3MIj2oOLqiJB9fzrN1aQtDGGvCLUbN5g9boYL0g2hZ1IfyH1K/JRr
         V0i/4K7jNshDp+IphQkWNyaUh6zQLHi+y/xMMKbKMrB2142tPWoPnmqTpSxs/8TGGgVR
         /BGOJWL/nO39WFa4NC7TpsdyhGw2EeRVG8k+SSLnJHi4wZrCzCaR76sr2hFBwsckbfPc
         DunZawfl8r7gZOjacSlpOzT3md2U9S6F69dHu7U7TqzlKw9wR8CDAB1IpOewy/WfvS/v
         dx82a02aiRUtIkC2YZfgY/LmNFc/eTLePKnkPVV/7o0fRo7hePXf4a2Gn75l/XDZ/4no
         XZBg==
X-Forwarded-Encrypted: i=1; AJvYcCXShdbs03lqHyWnNzoFs8j1KtTIrUqLU2BjWuBH/W/+ZOwZlFeaffcnQbrZ9NOiAaoJpbtjoYwh3I6ECJo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzBpztu6Kj6JbewhXhjr9UqUn9nPN0BP6SFDpRv4TesLSMwOxLY
	4VIon44+qnqSHsQnVHtTLG9n1U831QBOZEqHyEB5v/EmN0AcyZmQA0p4HtRGog==
X-Gm-Gg: ASbGncumFTTRaIfoPQLLO8WjWczkOm15RlmYARxPeMfjvI1i2NiYx8mEmuNOGnoYUGv
	R4Sbx5PZg7Jhln2ZtEu5rpECQxZMrpZYg2r23xi7gITFqiSfI1j9tkYetjC9XNiHFnDXWRB1KFU
	1RU0CADuhmonLXqTiSbzbR5qSWIYl/do3N7b3Mg42/YfcEBcO6KN584tWyvEnygV4o/MrE4nLX1
	2w19NJx++AYjt0S0iAbMH6wQu4sa0WhmVHJOsOrq8NnqvnojfI7wicqwPwEBx3UirFAVw/ia/Kq
	YuNmJQDfDfEHT+KKdTIPmo3ve26AfNNipZitWuQtJcRJZHh3E5K7mTD81D+ECxWbYtxGPUJeD+X
	x3pviPTVCPSf0CASxSDpeeSWWZdBJAht9owvlJJ/9M02ZqjqQsgMV752lGZKNUBc8/FlWhQ1XWN
	XI2t6ujM4DVhsJaA==
X-Google-Smtp-Source: AGHT+IEwedOJdX2C4dcT7YtHIB9g10cEcA1KXeKDB3iN+o2qBogEjJkFDAFvSZ4Lz3eibMEDLOuYqg==
X-Received: by 2002:a17:902:ccc8:b0:28d:18d3:46ce with SMTP id d9443c01a7336-290273ed885mr134399495ad.31.1760093333627;
        Fri, 10 Oct 2025 03:48:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f070basm53936325ad.77.2025.10.10.03.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 03:48:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9e179850-56ff-48bf-8cea-ab5895b6f935@roeck-us.net>
Date: Fri, 10 Oct 2025 03:48:51 -0700
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
Subject: Re: [PATCH v2 2/3] watchdog: aspeed: Support variable number of reset
 mask registers
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, wim@linux-watchdog.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com
References: <20251010080315.816628-1-chin-ting_kuo@aspeedtech.com>
 <20251010080315.816628-3-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251010080315.816628-3-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 01:03, Chin-Ting Kuo wrote:
> Starting from the AST2600 platform, the SoC design has become more
> complex, with an increased number of reset mask registers.
> To support this, introduce a new field 'num_reset_masks' in the
> 'aspeed_wdt_config' structure to specify the number of reset mask
> registers per platform. This change removes the need for hardcoded
> platform-specific logic and improves scalability for future SoCs.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


