Return-Path: <linux-aspeed+bounces-28-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13086CE8E90
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 16:07:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ9mX38L3z2xgp;
	Fri, 25 Oct 2024 03:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729786060;
	cv=none; b=G9Ls32zhZ8EUmhorMnaLJsDjPCsxucEduv8ZsA5jZ16JwLZcOyW2UMD8AUbzuQ9YIRBE3ewTg7S0I+2dwXGpfm7zMMmQ3t0JNUtXPosDBOOBbE0bgRgHLzQ3U208bdCg1Wmwd7tLVt6EAUnvGffzQbd3vPgt9vdXKJ8rvWPM9/MT7K3t3Nyyc0Xlo7kxKELik2N3yjtUS/aqb0cI1NxcfVrORwmyT6IZCj0g0HHeVQeLtGEnUjYuUZz8/ethipaiBuHj74Aa92AdNDbDgVC3eIw03/k0+JIViiY0Oe+Eo+MKjB+Rr8WzWdAF0rKbt06BDSX2hzR2u6Gh9AGyyQDL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729786060; c=relaxed/relaxed;
	bh=2TNe2Ym34csTaEuiRW1/O4gceO7dqGqww+esQnWO0lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azZKEatt+5mpyI8RQAhm9H0vWgX0QxmgSHFAhHjV7Y5BG2I8oG6TKrLfquLS47HdmwspDWia4NmhBhm2oJxjUNqTOKus7afvSkP/y5L/mtuyP/SKMGilulbaAg4DGmKpyhnH/ixaOPo7q24qOllq3RIz3v0u7bg7D9e7NcmKl0kAdMuyaH7FawyFgQNQxz4hvFIm3QDa8wDnEUacnvOk/NF7YhUOgJHpaz3hm83pDqbCqUqxqGcwqZStI9Ma3c9LbRnh7IatAjNrwRWAzxs1poGqkc2TyfNybIxtIwGgZFsZe4JGobTBaaKenWGpecyHcsZlTFamN+TxLQkCyKGBTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FPhLJcqP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FPhLJcqP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ9mT6YJhz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Oct 2024 03:07:36 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-20c803787abso8649645ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Oct 2024 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786054; x=1730390854; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2TNe2Ym34csTaEuiRW1/O4gceO7dqGqww+esQnWO0lg=;
        b=FPhLJcqPqDnObMQbSxftMRAbFe/8TkwNO0WZMh8VKgELki75rfRIRSUK6PGSTEZ3xW
         IstUn/jwzRxGPQI0z834mKqSQk6LkYgYnWAhNefOwknntJaGa4g1BVbI7/TiuX/gHn/n
         JX7jcYHJVqvmFSiKC8b2456zDLfz0YisrbjwQsRScErZNb7hJSQbb72ASChDAy1upMhK
         MC/8F78iQjophQvf40kL2LviZMzoiu+zuLsIYVGYjQT6tZ+IX7k3BSDc9Hh+ZJJP3d2c
         gt2QHTHR0QmlB0WGUss/+cXxjI97u/mRsoQebmOnrwIdayG0qsC+TceH1ujK4GNH5EB7
         6X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786054; x=1730390854;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TNe2Ym34csTaEuiRW1/O4gceO7dqGqww+esQnWO0lg=;
        b=EMfUAOm9u1DXs53wj2HUxJx9FcKWWHT7F4splzBuoL3NRR7BO3NmD9UqPlmTKeucSY
         MlFP+/Fh5Qw74F+WPlLhnzTwUUkeAoJFNgii1hrzx64HoC7Xc4D9tk+hlT1c4YUmrx9u
         bj5tRANHpCTIrldyQup1qxUsKPPXaUsQXWpyHqWVyNCwk0ZLcDXX7NEKA9hy3HkLNyxW
         l5r5izqPyN/E0owlWj+ptSfVBtL4fIEvT16una9n8/aqZKgPRQCL3qoDBXk6UkXusQJ5
         piq7HtrxeEBpsHcAvt5+bAjIJcYPb6M+6rjX4dIRiKKQCdO6JELn2jdVTKLa4gXfxTyQ
         hDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxNGOiLWSepaqfVpkiwC9fOfMjtMAjQGA0HSbz5xEGFTGhlLcCAGtuzsmRNsN/qu6yX+RXFMJ7vDoTeIU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwfncTm1281tzynNqKD6NpCQnRWY3+PjsGpr+zPZVNBn3x3Ru1k
	2g0n+XcWeVK4HvWzZ0bduniqCz0ulmi2zzBE9xu8WdUsYHusqfui
X-Google-Smtp-Source: AGHT+IHelvnAnzzyZFpgXYdYPCQlFtmHXCy4JGArTTYWPneli64ZPa28QteTqe35EW6LYZvcNZOMTw==
X-Received: by 2002:a17:902:fc4f:b0:20b:a41f:6e4d with SMTP id d9443c01a7336-20fb89650ffmr43374945ad.15.1729786053504;
        Thu, 24 Oct 2024 09:07:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0cbe5sm74037925ad.96.2024.10.24.09.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:07:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
Date: Thu, 24 Oct 2024 09:07:30 -0700
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
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 BMC-SW@aspeedtech.com
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/24/24 08:40, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:
>> Aspeed PWM controller has the WDT reload feature, which changes the duty
>> cycle to a preprogrammed value after a WDT/EXTRST#.
>>
>> Billy Tsai (2):
>>    hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
>>    hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload
> 
> Huh, I'm not convinced that extending #pwm-cells for that feature is a
> good idea. Unless I'm missing something none of the other supported PWM
> chips can do that, so I hesitate to change a standard for it. I suggest
> to make this a separate property instead.
> 

Agreed.
Guenter


