Return-Path: <linux-aspeed+bounces-238-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01D2E77180
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 17:08:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8wlp5s2dz3bVj;
	Sat, 14 Dec 2024 04:08:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734109718;
	cv=none; b=BhpAuFkajtQFwCoaikUDqy2yIGNYZyo+mMXt0jBL1zEMrwsS/cj/l6iAbGFaalRhAgZL43zp7V/BLCfQgAIKqXejcHqOlICJ7TuA264PHa0O83wLsUFwHgx31OfIXCuc4ut9h4u9gApKYf22/eQL4H7UmuUUsy/LmVIAlO67fD7EK6sN3Rtcd6074qTGqtRUMPDQeKaZHidQJf/DtW+VKC1pr2aR0tjNTdnVO8puaQI/Mz6gW9/JwI+EY4Wglr2XaaN0j8PlOA1wFf7df+r+hNOoMwti/h8ErEY6ZQYmr++hGSwesuDh9ZU6T5p+LNf1TaJZWLEffNSiIAyrrQMYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734109718; c=relaxed/relaxed;
	bh=S4P5h27YPOkyA+5/aC4d0mYq670kQsIu4WEG26jSUHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WFU6gJnuVymgsWeNGrmWtNsnb1pv/ugC+1zBtzxaVJSotyyWx5p3GJFyREUUUbb4NZsOf45vOx9L+y2v1MgSyo8BGZyfPvQfpHK1M6ZZQulbcSdsvhKCe1cN1X321bqscOnERuqjwMLVggDKx8Ow0qdjRVTKwVeoUIsgmsBzM2F+tq/XLgUsMInKq0BU2bXT97Wk9gajASSVi3I4FAG6r9j132V2bYenms/c4nHYzclgp4YMAPHLGBB7+pIaryIiA8XFz7Wtln9qRiQBPmCAiRzkam7Fwu/CFOhiZ2qZeVX50lktrdymDjh2vQyoUhTFZJN2H3AaXiYZAjXjASW54Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dI2K/xNH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dI2K/xNH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8wlm4gR9z3bVK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 04:08:36 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-725dac69699so1843549b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 09:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734109713; x=1734714513; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=S4P5h27YPOkyA+5/aC4d0mYq670kQsIu4WEG26jSUHQ=;
        b=dI2K/xNHnRwpVi8Nmrwp05XU0H5UksnTYPqBxZ80WHr7yIeSm7ZDuD1k0Da7bh4aoU
         obob4LHaNISzyIPHlgCs2Tfu4pWl4JU/3AgrkWc4Njv1QUMBOX3PzCiyaQBl284EV7nO
         oToGPu7tp5brtQ697COsJdzmYTdWYc9CNeeb85c+dK5Kjuwlc2rnQqSbmHVu9+3/4eCe
         7ZUczFd7HZn0utPCyv+fSW5EkVkaMuBok0PNAx3ZXMqvVIhaCYAzPJsDT36jErKkVDf4
         0p+aLfLUtJBAziZN2nqETNMK3v+xft6kVz5+kAhCeazf9D5MclQFOjqIUw+umIMzbYAM
         FYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109713; x=1734714513;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4P5h27YPOkyA+5/aC4d0mYq670kQsIu4WEG26jSUHQ=;
        b=wJQJwFs1Cd4z9EM0umvJC33Sx8VpLoBn+6etHZiiboiMM5YCQ5lTLJBWzqCt6qc1Vq
         hogyHmBoMtaJ1rhHJzqdlzfgb1ALqtqsRrEW6xjS9Aj3JtRyL9m4SkOY7fo9QicfXwAi
         etiOdutnw31C4iKYX8TivSESsxTkL61SP85SbFAYuE6AEvbhk0MujOusw7Nh9JLebTTS
         A84zx7X3Kt9qjko5e2jOdzAHyVSnQE8XQcGXl7oDiNUurjLcqnmU1+6Yweoo7c7GteFY
         dGvuLu9duvIhW/qxmPAZCsvau5F8qRwxY266bDDFTRk2ivhZo8jrDqkgN2Pc9zto6GK6
         bxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkq2edAyI4gi3Mk2SZ6MAjMAspWO1mYP8DltUiTZg2bmEhq+b4u+khCgEjcKdbG4jBQh3GP4oG4KpPKY8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydHyNWtta/y4Py8uUL9xU9tkPLXEO26MB9fY0L1XDyUlpy5/45
	IxUCyu4+shFcH4+rgH79lXEmcGJ/j4bNHADXMLU3VXRG6+o3gWQ7
X-Gm-Gg: ASbGncsqGV16gflkXOLBBLsocRnxp5Sr4/zae+gTnD+eLoj2oSyQtF9OqO/ZGvyt6yP
	9SohnT0vjPAtR1oev4Ug339sE1/3BSMwpe4ihWXL9PbDUijg7TQPbiyyZu6mKapHlqG6kuMOfX7
	7yEfCn6/AaBN0eq9W0KaDtorCLGiouK4eFoRoTVjpyff4jLRYtoaAr+bv+xWJK7GCi1cAveIsPx
	z/dE57n92FJmEBkjyF8NmITx0vJrJxzYMjiKEo5R6do7aeUTzVIaVF7vSvwPx8Jm80KVzRol8L8
	arU8GVCrx/ZfqTYuuxLB6xO9oTj/EA==
X-Google-Smtp-Source: AGHT+IFNl1jFRcUys8+E1szg3JT/tH8apnoiFfDfmvVVa4TzEpKSuj2z6i8x4YQXRdjMljGMn4gdeA==
X-Received: by 2002:aa7:8b4e:0:b0:729:c7b:9385 with SMTP id d2e1a72fcca58-7290c7b9577mr4155847b3a.6.1734109713452;
        Fri, 13 Dec 2024 09:08:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5380sm13611b3a.5.2024.12.13.09.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:08:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2713e85d-f88a-49d6-8221-151e8631758c@roeck-us.net>
Date: Fri, 13 Dec 2024 09:08:30 -0800
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
Subject: Re: [PATCH v1 1/4] hwmon: pmbus-core: Add label for fan and temp
To: Ninad Palsule <ninad@linux.ibm.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, eajames@linux.ibm.com, jdelvare@suse.com,
 corbet@lwn.net, joel@jms.id.au, andrew@codeconstruct.com.au,
 Delphine_CC_Chiu@Wiwynn.com, broonie@kernel.org, peteryin.openbmc@gmail.com,
 noahwang.wang@outlook.com, naresh.solanki@9elements.com, lukas@wunner.de,
 jbrunet@baylibre.com, patrick.rudolph@9elements.com,
 gregkh@linuxfoundation.org, peterz@infradead.org, pbiel7@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-i2c@vger.kernel.org
References: <20241212214927.3586509-1-ninad@linux.ibm.com>
 <20241212214927.3586509-2-ninad@linux.ibm.com>
 <f9d881b7-7301-476e-b281-0380dfcf0e10@roeck-us.net>
 <c7717f89-65cc-4668-a3e0-ee042cdcd426@linux.ibm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c7717f89-65cc-4668-a3e0-ee042cdcd426@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 08:12, Ninad Palsule wrote:
> Hello Guenter,
> 
> On 12/12/24 16:06, Guenter Roeck wrote:
>> On 12/12/24 13:49, Ninad Palsule wrote:
>>> Adding label files for fan and temperature sensors in the power supply.
>>> The openbmc application dbus-sensor(psusensor) requires those files to
>>> consfigure those sensors.
>>> Note that prefix for temp label is temp[A..C] used instead of temp[1..3]
>>> as dbus-sensor(psusensor) application calculate index based on last
>>> digit in the name so we do not want to make index double digit after
>>> appending page index.
>>>
>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>
>> We are not going to fix userspace problems in the kernel.
>>
>> Guenter
>>
> 
> Thanks for the quick review.
> 
> Sorry I am not clear on this. I feel that it is better to support labels for temperature
> 
> sensors and fans like other. Are you saying we should not support these labels or
> 
> I need update in the patch to support them better?
> 

There should be no such labels. Labels are supposed to have specific meanings,
such as "this is the CPU temperature sensor", not vague meanings such as "tempA".

Guenter


