Return-Path: <linux-aspeed+bounces-69-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0E3E6F092
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 Nov 2024 22:19:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XgFf90rYbz307y;
	Sat,  2 Nov 2024 09:19:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730499585;
	cv=none; b=Ihp0Z7RsPMVs9tp/putJXizJ0e3C8MYYkSoCsaka7bbetstI9geR9yqQBu2qETU8OYpuAhAKG+PkP+Mu5Tut/6Lec58p5B6t/zY3vim5aWn1YVEuLlOSfyDFLMHKXH1R28eZuxgqcJX8D5h4wblXheDvFspDN0cwhS6XqXG3xajuohdiuexAxR0Ku1gSkE1dcn1sqaah/0bjwNilUJJY9XPnqIUCKvtsMz323Fp84pjdqS7Azc8tVHn3WrBfB5Duf7IYkgcyRWT2jdgCzg4QhXI09cuU1Cn4o0Ggd8+z6jcYDLNYDQwNZU7xCr9OcGqj9uglwsP5Z3ZWVwZS/2NVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730499585; c=relaxed/relaxed;
	bh=ASiyIHn/3ii7xbeQI3Xm3CDe+0D7uWXjTz/CkcuvjF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPXC+kkwoYAqCV4QNs874Vjw9Rr+Btu+WkljX8KjCGVuHarA2Vt1U+6fCuq9Wl8vPbPn9j3WHOLSWSeN0BtrzrAI/BPz/UH/cqH/7u0hFWeQALg3/QwrvGmgqFAH6/2KmlZK/UyZnyPj5IFTZjXc7HvxxGXPX2pt1VXQgqwC910lIuY+vHFiJh7fdSwD+COYbr3dEGJLeBAhnRG5jFp8e7ohTsF+nA9LECMb+xOFz46EIlKCsiAzryF1tsMQ5Vop6yPb1yGiP3ub3QfqPJDBNEn0kLykEJWocPuD5B/+YVJiBgT/59ztQZjQrJvNilItzWJNBAjytsxfw5ptCuq4/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N/bAQr1q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N/bAQr1q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XgFf76vt7z301w
	for <linux-aspeed@lists.ozlabs.org>; Sat,  2 Nov 2024 09:19:43 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so1782860a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 01 Nov 2024 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730499581; x=1731104381; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ASiyIHn/3ii7xbeQI3Xm3CDe+0D7uWXjTz/CkcuvjF4=;
        b=N/bAQr1qDoAagxmVQbmRTNOGSaK7EJDsiJAv4CeKDzzx5ZmgdYYEc8uG84PfZLk8Wb
         oAV0PPCEkJpR0OYHKvU8DyyWMLhtGmAgQFggYN4M5sm4BDTuUYNK+VPajfjcOLg4qquD
         6nfcQQ/E6PqRL3GnBowGGVSY9AY6dJOMfTyG33HunfgzAgrpTjEKEZnY3dj6rfDhdADu
         HzUYEuXWXUyStWGEcmQ0lFyo4cqnvSXmk2h8qOoEqZ034kYkq5n1TkvFEEvccpcHLMvb
         BnKZ7VAwG2tOPmZYRFUWkhkX485rJRPxmiQp0UpSC35OxbWW4ClExHJnU8kuhv3zQwEe
         z0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499581; x=1731104381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASiyIHn/3ii7xbeQI3Xm3CDe+0D7uWXjTz/CkcuvjF4=;
        b=RUL1NJ42Zq+irh4L+5V40LPGqBytmbX93XDkpv39tp7tl/yWWuMToW0qQNJ5fBVimC
         8s6Sas79xXWUOE8czh9t7Mt/hIGgKq/GLrawJprs/my4xNupWKukFKRhdGEXZp4RPIw+
         o3br1JDBqCQeCHfDWXbA3MnW4JfvJwW9qE6Q8GvGtXIiAMKHR8hrfyW+eQaPjfgOnqbK
         +reC+qXgwfpqlwXlI6q3Fb0ZwTrxPq7vQQ2gVCOTPP9wnPVEpBgKa9QCIz+kwK5iZl9v
         xOBuXivGXYTj4+ptjlmGh8/68E3zem6bh5oA+LXFIfAN9g0+0MopzbVHDwsFNmo0wSHX
         nlZg==
X-Forwarded-Encrypted: i=1; AJvYcCXrZ5fqLqPD6zM+Inh0VXkG7N/v/tYOYqWgipgWFBTUu06dtzGDmUfzde0D2nVLGKhvyLDPbR4LGNUkcUY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx0tch1w0j0F2BbXmKy6nJZgvMqwiogOGpm3POlwQIHdjceCXMP
	iKK1i4Ah++UiTwfXeVjJl8NpcbFB2XCo+5fo9yTf2B7O8lJN0AKy
X-Google-Smtp-Source: AGHT+IHAfJoElGQs4UKDOuFUgAvAywk67B41uHrrSM/kNHKQQAzOFjjwRyqFsY4E1MH6AuvamYfeqA==
X-Received: by 2002:a17:90b:2e42:b0:2e0:7580:6853 with SMTP id 98e67ed59e1d1-2e93e0fab5amr11494578a91.17.1730499580566;
        Fri, 01 Nov 2024 15:19:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da98448sm3599311a91.6.2024.11.01.15.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 15:19:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c91f8b3c-ae3f-4d35-8b7f-2fb2b7cebebd@roeck-us.net>
Date: Fri, 1 Nov 2024 15:19:37 -0700
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
Subject: Re: [PATCH v4 2/3] watchdog: aspeed: Change aspeed_wdt_config struct
 name to aspeed_wdt_data
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, patrick@stwcx.xyz,
 joel@jms.id.au, andrew@codeconstruct.com.au, wim@linux-watchdog.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Peter.Yin@quantatw.com, Patrick_NC_Lin@wiwynn.com, Bonnie_Lo@wiwynn.com,
 DELPHINE_CHIU@wiwynn.com, bmc-sw@aspeedtech.com, chnguyen@amperecomputing.com
References: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
 <20241101121201.2464091-3-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241101121201.2464091-3-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/24 05:12, Chin-Ting Kuo wrote:
> aspeed_wdt_config struct is used to store some HW configuration
> information. Changing its naming to a more generic one,
> aspeed_wdt_data, in order to contain more platform specific
> inforamtion or SW callback functions.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

I fail to see the point of this patch. It is just unnecessary churn.
Just like drivers should not be renamed because of an extended scope
or because someone doesn't like the old name, renaming variables should
be avoided as well. Such renames just make future bug fixes (which may
need to be backported) more difficult.

Guenter


