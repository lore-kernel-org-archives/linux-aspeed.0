Return-Path: <linux-aspeed+bounces-2801-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D37CCFA19
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 19:13:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2X0t2Hkdz2xdg;
	Fri,  7 Nov 2025 06:13:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762456430;
	cv=none; b=nWBVXlMnoz2i6hkthHzdDfb4bTNtPw4gb5xq9vXsEFuh3Zr7JEyIxIJMoZTaWKRpOqB5y1oWst1Pk6FpnMm9eDAWpAClNS5D8AgRp9G9Xbxt3EgpLusUD3FH/NOjUh+pzlDQ8LDaCeco2XAurMxokB/XAJjPWaoSqBuuqsa3d8YjJM3FOZL5ZowIG0yNB9iTs0uyOLhE8mynNOm7Trb+El0J53fW6b85H9flw2i8N2t8W0sn4VHusAbWjahE/eig3IpkgfhrF9weYnFYBY/puIMNxGBQXXGatYmbZLVTwqYhmBdm8nmbvb1IRN8OKdVfJcshzx6CWF1G/d9sjl8yHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762456430; c=relaxed/relaxed;
	bh=Xs3IJsZszZbg8RTJIDmhoqjNZ28bmmKOdR37EWAGl0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0avlxQCGjkMclwuTEMrpCDUbTQBAWMObc5oQmzlez0vKPUoPTIUUfgIiq3rW/dpjamZcRMWxUIxeAa3MsJPgoOJgI71fratWMa/HlYRq7u7MhunSqcZ2f3gsT8Xl4G2rpls9ABOrDt1VKBmzuawJwgMtc/JunvTtrzepoNdhxx7rERMcagVHPfh8eOaOweYooW2tJrajhzFyV2n58lW8esWPu5rd6GKqB/WAzZdnBL08UXoqF1ViJRng76116VX50bzqiVsZaReGMBJV/0DlOZ+szfWWP3aX65HIYtB6kjvW/kYsxTF4Xg5/fOuOT6dNstah/QHvV708fwKepZRrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q8kVd1dY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q8kVd1dY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2X0r5Dysz2xQ5
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 06:13:47 +1100 (AEDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-b7270b7b767so17873466b.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456419; x=1763061219; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs3IJsZszZbg8RTJIDmhoqjNZ28bmmKOdR37EWAGl0U=;
        b=q8kVd1dYkw+zDt/byassPqphppj3i81tU4Ox485oZa8Ukbq+3Cy2vHh56jqbZrCpFh
         HFovuDZ8w+nCldL/ckiEPACkkRwX+1HNkmgrXViSI8ygwuS8meLCr2okwbLo/NDX9ugf
         J7SxgoCzzR3zHHQiFn2zEGLzZuYLoLowd352yF4HLFjcLV/Sht6YL3gBOL1eaSUD4k4/
         u6fgE3pWPJIEQ4lOa29kk364iOax3v/+Sbx5UNFsO6wdVNQaFX4y3hUa144IG3yVggz3
         3Pv/qoasWxmraqjagdF8VmIjupwf4zo84WIXm9VU2+9Q9Y3RZCWGprA8/Lds6LnAOAC4
         qTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456419; x=1763061219;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs3IJsZszZbg8RTJIDmhoqjNZ28bmmKOdR37EWAGl0U=;
        b=Id3M6r7WUMF+d405kcy4YpgQt52mjefBkqfEsPMrIHTFZXZDOlOZ9q+SwhVV6lkiQI
         drHdM62m2+zmfkTm3CqFTG+pM+wOAG33uhgGByEFUePOkznVoZUOakBsj045XTAqGYu8
         4ypCd1JJo4tOSKHPNjIBPm2WzKXVu1v3q7HWI1e548DD3wHWkWMnMtcIgD/MMV7shgt/
         ArFH9n20BHPcTUuwxE/ZCavdRggQr7ec0w5z8ZtR+p/8f6i2AlAyldeP9lYExw5TdSzY
         iR7s4747Kk6fMXv8ySGt0frdB7I/d06NO9pmgSBqjF/GtKLmsf7d1DnEuyE2EnRFXOhL
         bBwg==
X-Forwarded-Encrypted: i=1; AJvYcCXk/A2mmtMkSA2Qe+sWiBKQMb8S9d4TvMmPWHyvGGytGKNgdwBa4RKgdww2SIwiQebR84OMEtC2hVOaTWY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRyHuvrXZLKjee3ejw2lJFrYy7P4AtxKYBp3wi37lq3H3GaPrV
	drWK0VF9ZeFMrxAgUEf8NmR5EYq882Y8DI/I2Izc9G4EWnWHmoa6O5KcMp14sdyRXPg=
X-Gm-Gg: ASbGncuJ/GU06xeL+iIS+3oTAVAVhOcHILPzPjCFp2ZnwGtXZ99l2mlJ1TlTZIJhfxE
	kWEHOBK+PRo39BqhIIszjItvHONbIyeN7OlJXWrYU5O8KFy26kas/Pg1I86WhRcx5AFxitxX8J5
	2ccn4hGwUcQJdkCeuLzJMs1TeJj9icmpjy4AHv4SDg8lB1rvJi5VcvmV1RGVIjWIcO6tMPnq6tg
	1Bc8Y34qmtRvaNo9ta/pJ1kWcLOMNJ0R+yqnhxBys2afH0wpyNggiNIepcCsrXX2odTAMmhVFyp
	CzOsFPHLZr5gzGmAeyUeOjQ8Ywu5KqV5wpmFfMIxvbtIr5eOrm2j+DKE68lwNqvvAlfluorL8L6
	DjcUA+d2kYYJatNi34E1EQ/18bx7Pwx5JVgJAXByJE2BdU4BBC24UODABd067PnFgVFAN1BSyGD
	7lEnRPig/rMI/kVi2WDUtU
X-Google-Smtp-Source: AGHT+IHph4UVtkfqqcOCpm0MSxBkSn+jtLUIbiXMRaQcHydRVPc0JgGsJTlozwoQzK/2CK5O3tSVNg==
X-Received: by 2002:a17:907:7f29:b0:b46:6718:3f1f with SMTP id a640c23a62f3a-b72c0b02375mr20083266b.7.1762456419105;
        Thu, 06 Nov 2025 11:13:39 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97ea95sm27718966b.44.2025.11.06.11.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 11:13:38 -0800 (PST)
Message-ID: <cf23070f-8a3c-4c13-a46c-dc95f044c936@linaro.org>
Date: Thu, 6 Nov 2025 20:13:37 +0100
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
Subject: Re: [PATCH 2/4] gpio: aspeed: Simplify with
 of_device_get_match_data()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Srinivas Neeli <srinivas.neeli@amd.com>, Michal Simek
 <michal.simek@amd.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
 <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org>
 <CAMRc=Mchtho0yDsSp+wwBt=yBGg1+3i8ifkUrip1MJaq-uk+0g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAMRc=Mchtho0yDsSp+wwBt=yBGg1+3i8ifkUrip1MJaq-uk+0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/11/2025 17:23, Bartosz Golaszewski wrote:
> On Thu, Nov 6, 2025 at 5:16 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Driver's probe function matches against driver's of_device_id table,
>> where each entry has non-NULL match data, so of_match_node() can be
>> simplified with of_device_get_match_data().
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/gpio/gpio-aspeed.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
>> index 2e0ae953dd99..3d675b63936c 100644
>> --- a/drivers/gpio/gpio-aspeed.c
>> +++ b/drivers/gpio/gpio-aspeed.c
>> @@ -1305,7 +1305,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
>>
>>  static int aspeed_gpio_probe(struct platform_device *pdev)
>>  {
>> -       const struct of_device_id *gpio_id;
>>         struct gpio_irq_chip *girq;
>>         struct aspeed_gpio *gpio;
>>         int rc, irq, i, banks, err;
>> @@ -1323,8 +1322,8 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
>>
>>         raw_spin_lock_init(&gpio->lock);
>>
>> -       gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
>> -       if (!gpio_id)
>> +       gpio->config = of_device_get_match_data(&pdev->dev);
> 
> If you're already doing it, just use device_get_match_data() here and
> elsewhere in the series.

That's not exactly equivalent, but I guess it does not matter if driver
probes only via OF. Sure, I'll change it.


Best regards,
Krzysztof

