Return-Path: <linux-aspeed+bounces-2418-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FA8CCA476
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Oct 2025 10:49:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjk5H2yLnz2yrT;
	Fri, 10 Oct 2025 21:49:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760093363;
	cv=none; b=W9+ckP1pjFwu8hr/1hB+zpTQVbadkh//udwIHMdj3Y9WEHAWSnvkpobDnHxM1QRjWxQE0vZM63ez9C9yMg+jp61dnA0mBygu4VvrrrfzK8kSjpuebYmLNMxBMku0uqUxOAwJsMfRGRcWTm6BfYTKN3cvs34NgtoOHhvth+41lq5jcogYpgJaNwXhRyq8jm5Gc5wV/FYdt+DwFrDzsNTD8fP7Kb0JK4h9r+cf4YS8J0j6aznuE2ZKPVlJb5658vi5lPI/ycweUnwafA02Av0ofkaHINnvncDjf8ZqZu0i26iqK7IFwtSb+p8mge8voth5f6ISPCgt++hIAEywO5etrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760093363; c=relaxed/relaxed;
	bh=QzPIUE0kq7RazblEJidW9b7e/wLqz9BuPeB8RaG4tE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kd0gh+/vSP8fHRF2IsBmtaeTwALieQ7vpm0DQenKcCZgqI9nKKbDkOCTSCpy/w64CwYAlTo74SrFkcl5MT9oRAXfLdjx+mcPqwil0Vn4zsJ9gBm+8Rk7Ik3vm4QdHzKxej6T0osEr0biibw+vZOmaMGBBvR/4i3Sf0hBCHOmZki5HcY63l4bVBlC3i3ajRdUj3dHvaBdLQV5BCFRlAyOJUcvdxWLeVyj4U/CHAlfjAOWny45AzljZiA2kb4uVK9NlHMY+daafUSU9vHOsJplIxWmRttvGV1h9n5zLKhb1eg5ArRRWthjs7dmHVnsCpLiDLobOU5AaB+wXxX+lUX2mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EAAWSqGp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EAAWSqGp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjk5G688nz2xPw
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Oct 2025 21:49:22 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7930132f59aso2718099b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Oct 2025 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760093361; x=1760698161; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QzPIUE0kq7RazblEJidW9b7e/wLqz9BuPeB8RaG4tE4=;
        b=EAAWSqGpD5bQyX7BPZLVaEOYR4zbgZZXCqwzhLr13j/uxVHDVkgLUgwH3XUMFdii5W
         Rf/dLV9Aqydy1EdNV/PEeYGgtiFpA0z55e3+YSdQVnPw6Rj8C7br7mbO2jUv+Y7YX9C+
         tL5RRgx6/EaXjC7jecdv84qslgrSMPTcY1ryHvBPagkJJ/cwfEEOQ4svXgH6w2tO60Bc
         9YQ6tLCgub7SvdO4UndAsZCO848NXgcNzcuzHzJdCfopr6vBkQs/Ybv+73JyYSV8JlqM
         j+VHKOU3YWNwWuX2gfdOgdEufRXvCNiE6/crKcgDL3k4YX8nT2RB9388MyqhKx+VDIWx
         bQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760093361; x=1760698161;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzPIUE0kq7RazblEJidW9b7e/wLqz9BuPeB8RaG4tE4=;
        b=NvnqfRD6aVqFzpdjcIcrYBYryKP71oOHvr+76FI1f3pBzYC8tUj7qd5QOJkio1zS0a
         SFYnKGuVHu0AzsAI2XjxB2Zq2Y4f1L33zhzN9tlci1bPm6OseD4A367c1BoSfMSHCrT9
         migZiuSUTK16y6nQsr3OVKH2Rqu1MwP0gHG3lsVvB2t8Nkpg1UFMwvVeSGpyOGMxjls2
         3BOSC+lCi9G1dR68iO9Wk7lmY2m3XvTz8BWlI7lanH2Y+VKRx2dka6ujbGNvLGEYptgs
         XqNZAimKpS4py3YA3jXpJPUSaVDLtv2X7qiWdLrVckVsPEaXW5ZDSyXOBBB+tGH8BB8D
         D3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8uvpjVmYZThTM4vmcHF4pX3aLATIpaxCRJe82qQednywKKycP980K93IbzIWoencxDLv7xFI9OGqWrC4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyzzeMa3t3KIWn3W4uNaFS9wHc2WA++k2b3d6YQ3SOXNYrXIXTi
	jfoEjFuT/XIFRuicaEq2M/QD14FYnKwzcdmQ4duD6Sg5fXRWCqoll9rf
X-Gm-Gg: ASbGncvGFX9vuf0qGTOQ8BqGkzwskK1+RU5WLA11GvFG1Af975m8t7DvFza5hDcjhWO
	yZKgUL/NOSDsPnnx8EXbFIdn8QdZeyhzO/3RV9Fm2LfXdCMwPp7jpkDB1OdBkakkoM1EEv+AxEW
	IcuXkjKOPOD2lZjOQ+7ihsEtYtWbSuMHpmfGDp3s4PGzxJk2yjgmL8pFY4SqvBS0u5QAZRZA2DP
	si95+QBVS5B6sOHE82q/7OuuOmbVsrHbDu2aJC//eIm+tbI5zj0+1wra8HrXEXeCoekE3VGWkE5
	w+r1iJ1GQASTrf97HLYLv7E1i1KzdQTc2ecxtHWc9yy7rCSzHHOdE5eRw8uRA+KmBcp+sn/Ntc2
	AlN7me1h6ycP55ZteMvETA7XCBLiAqeORlu9lTLZGkwDq0SoxNnpUMls8Gxvxc9HNBmCLD9nSQS
	lI9uShNV43GHBm2w==
X-Google-Smtp-Source: AGHT+IFBvTAbJQG+MxhyANCbjpJn05Ip49+Cj9nha4KjK9n7ztA6cSQ8VpgOYMJmhMkKmcyk9pdApg==
X-Received: by 2002:a05:6a00:80c:b0:782:5ca1:e1c with SMTP id d2e1a72fcca58-7938723daa6mr13371334b3a.21.1760093360826;
        Fri, 10 Oct 2025 03:49:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d2d2e42sm2508787b3a.62.2025.10.10.03.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 03:49:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8424b26a-e267-4481-b027-b372700ccd0e@roeck-us.net>
Date: Fri, 10 Oct 2025 03:49:19 -0700
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
Subject: Re: [PATCH v2 3/3] watchdog: aspeed: Add support for AST2700 platform
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, wim@linux-watchdog.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com
References: <20251010080315.816628-1-chin-ting_kuo@aspeedtech.com>
 <20251010080315.816628-4-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251010080315.816628-4-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 01:03, Chin-Ting Kuo wrote:
> Add AST2700 platform support to the ASPEED watchdog driver. This includes
> a new per-platform configuration with SCU reset status register at
> SCU1_070 and support for 5 reset mask registers.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


