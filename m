Return-Path: <linux-aspeed+bounces-995-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4495C282EC
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Mar 2025 17:54:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDsSt2Qjrz3cB5;
	Sat, 15 Mar 2025 04:54:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741974878;
	cv=none; b=JqWKVjEob+menzYU6vSAkhvdVu4adrvh6sIBFcLZaqAxzlFIs9c/nTPcMZX8rj7Bq6poGAzGALkHneniDEnMXpmJCHTRZR6vpRfJWn6cJg1NrmbOI37+qLqHibNp1zW/j00fQPhco2OBRI9xJrvnYws/picBdRv+GeP2xe7m1HB5EnzteUiSvmGgvBi5/tTYy0I2Oi72X/KISSF/MSFmAelJ3+Wxnh9+m70LsyIcztoqYRqeZL4d4IQr57IY0RxaIzKNV3gY5vR7Am7xMe7LpbF0cNhHMLk+cXd2PzdG18bFwZf0wpoV1+mT9343BEKMBijMtPlT6LWmyBN/F7YnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741974878; c=relaxed/relaxed;
	bh=iXntnSZAYPIM+jxaf+mIa8NQuEJqCGZgPyMOWTcNl3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcatVtSRRqqioL30qb/8IZsWZkpHziHLOw+XKL3VzALrTpGE9wVwkESWZ2K0/DTThf97oS5UBmY6iXa6Ih5EWQr05FbTBVQETGrY7VQZi5th4h6WxnW0VAQHibhptwUH3t6wzAINmPRMn7W8iWCQFPFQLhdveD6Uu1mfcp9HX+j/dmM+MHh9Ah3+U7cTlWvjKx+fXIp9Hs+KkZIkt9HMywmHl2MsbVtFjWzsyeKsnFHKcN7wMbTCI3j5/1tpb8hh1ryDhLOybzhrnk/uCdHK0/PZLCgtBwkxEBBRetO51TZ4WmPNMM7uGm7Tu/jZaBqMNiPDyZ4eshyniYE2cZRWPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hBgTpow2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hBgTpow2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDsSs26qZz3bsM
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Mar 2025 04:54:36 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-223fd89d036so50664235ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Mar 2025 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741974874; x=1742579674; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iXntnSZAYPIM+jxaf+mIa8NQuEJqCGZgPyMOWTcNl3Q=;
        b=hBgTpow2PsAl/Rzix8K/1NlfqJeaEC7CVTFortFC44CGU4flbR34UQdE7c8lMuopcm
         JbCrOV7RyJj6T2v1XUObdFwSIy/+A81OcDutOJ658n1t/CSgcUO+FqyrAKPXnotkLwSb
         11UidQdknktp1MaO20tZqbbygF1HTRE8ktFjCLssM0YqsTBo7N9yzFvV1rXX/44zTJs1
         3bz5/K6YcYAZ4k9wQ60OUlxz3zJ1boLE2h8yLvWXyoq5b6ekI8lx+UhKkKi35Smy86sF
         Xx0TEYxB8au2Jdu4CMpG0fcexn+sThIUIKnjkNvR/3Xzu9KqH8EKiNUItqx3t1o4AWGU
         AfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974874; x=1742579674;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXntnSZAYPIM+jxaf+mIa8NQuEJqCGZgPyMOWTcNl3Q=;
        b=YlHLhNhMkC35p0bXoZsyzov8OgKk/1DYMViIKJYkb26gwweU2DCt4jbFXrlCNWyROD
         tGCtKxWJVyY6WoRNW77Yl4Ix7FSECsLNseGz9aaIeX1Wfz7F8eBv+g7cup7j+VmSBsnW
         WEX9z4as9VLNZNkxBU5gKy6JSEyrLiqHtbClmZTzAWJ9vMc+lZj2UewSecfAzfWL6THe
         QH/DWt0NoJsCFc4W7t8O6GYu3EWLPRD1rB1zTDuNgQ9gxDGTg6lJ0YYc4HB3uS+Yy/SS
         BB9Si4W/6pOJ3Gv8GzAto6nmVdTqoPqO4deZf0epReDe8j28tHlXDGKlkRYRlbXW/FEj
         iY6g==
X-Forwarded-Encrypted: i=1; AJvYcCWxyUtMlu/UxOlS2mAI60e6XxSxzZh3ylsdbjEnkO4N0ku+ubl2m7bLVW8pQWz7zdYQXaXy8P+uVu0jx4Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzpM2aawzQlEL3ksxRfDPTvRy4P+cxQ4PiOLcj7Mq+PN09iJp++
	BWMF756wokxJQ8E/rn4coP0Df+ne/M11P0EkJYXolgf0XIYWSnC2
X-Gm-Gg: ASbGnct7Luq7mkr5sqz4ttkeGlyzC1fSsww7KVNRdkJoeUEI4k18ZitUx4eb+OwEWI9
	7rPqSyjvE//j7pY3Gv9sKx0jGV5/SL87ILARy2tuRfYQ58/YVxRC+WM0DOnXI0etm8NyxsOYxlX
	K443Kvv+4UTNwKhZtvjdBtTptafJ/YcOQwQpwaC4VEHLXpqkP9wz7u9nPtL6z/Nuqj+fegdI8yC
	c7snSNopyPb8zVFdGI1ls5taYtCHy5GXHvksbTqIvsEQ9CNkNyDYRyZQSeLDCEjLJWLuJP8P1ET
	pDviVjW/RBNFXDA3c1y2PUmE1mtlIlpzwRMxRhKbx/wrftMJ2z+ZHiOryRgbntx3RJs2+lEa1KQ
	jgL6RnZMr1glM3/dI1A==
X-Google-Smtp-Source: AGHT+IFRwBgdl7FuQhUqV8cZZzVwzJUCim9MXgjq09Y2aIttdNEczOrIm9VXfo4AxaHvW8u0AXsCIw==
X-Received: by 2002:a17:902:f686:b0:224:c47:cb7 with SMTP id d9443c01a7336-225e0867fa5mr47944505ad.0.1741974874297;
        Fri, 14 Mar 2025 10:54:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4d95sm31420535ad.244.2025.03.14.10.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 10:54:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <32e3fd04-d44a-4923-8323-02c53e8dbe82@roeck-us.net>
Date: Fri, 14 Mar 2025 10:54:32 -0700
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
Subject: Re: [PATCH] watchdog: aspeed: fix 64-bit division
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250314160248.502324-1-arnd@kernel.org>
 <9ff3ba59-be59-4a2e-ac1a-5ce23b1b3fba@roeck-us.net>
 <71b81647-aa39-4c33-b92f-2c9e6d1e606d@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <71b81647-aa39-4c33-b92f-2c9e6d1e606d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/25 10:39, Arnd Bergmann wrote:
> On Fri, Mar 14, 2025, at 18:37, Guenter Roeck wrote:
>> On 3/14/25 09:02, Arnd Bergmann wrote:
>>>    
>>>    	if (!of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt")) {
>>>    		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> -		idx = ((intptr_t)wdt->base & 0x00000fff) / resource_size(res);
>>> +		idx = ((intptr_t)wdt->base & 0x00000fff) / (uintptr_t)resource_size(res);
>>>    	}
>>>    
>>>    	scu_base = syscon_regmap_lookup_by_compatible(scu.compatible);
>> Does that help if the pointers are 64-bit on a 32-bit platform
>> (multi_v7_lpae_defconfig) ?
> 
> Yes, that is the problem: resource_size() returns a resource_size_t,
> so this is a 32-bit by 64-bit division.
> 
> Pointers are always 32-bit, CONFIG_LPAE only changes phys_addr_t
> and resource_size_t.
> 
Ok. Thanks for the clarification.

Guenter



