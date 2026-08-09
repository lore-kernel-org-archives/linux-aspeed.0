Return-Path: <linux-aspeed+bounces-4666-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF67C5AE49
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 14:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJ19v3zHpz2xyl;
	Mon, 10 Aug 2026 00:54:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786287251;
	cv=none; b=FhXHCy0DDMgibWW8+uRF8dJ/4PmIC3T5F36WU7hhn4MYCTchgYVf34kebo0ayatxPN8QKPYUP+B7Gu6OykmYgUSHM5xWJ8UNCFY0q1LTjYPWA5KUuoOBisskhvC75+75Yk7rhvFx6QNcqGdDKxvsC+4BsjiDktjGkHDvMWVSEhiGVVKQxv6uYk1c2+k3enhD+ZX9IZ5B8vu5JTI8uLY0iaWu1QQG8cNTdnr+5s9FaZ2au7NJsFEtXGzz6AbcqWpK6llCN3/Hr3P+C4NUuOxkm+Lhajk/pyht6nmGGqRks/FWD7pVS/8FbffaJ5Vr3bdcERdqYMIUv56gY9XWTDnJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786287251; c=relaxed/relaxed;
	bh=H/cw6oMGvUHB+hNpkuOSeNVySjC3l8LxiE9FdEJYQLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSfQx+MFYV3ovuQqWpGRVRbobcNlMTxxaL7aXvN8fTgQ6kff3PyTtTNy+GZqRn8euSJD+7ZpYPvFPzEWbSDiQBaVofsKMCS8ZQ2ZzacHF6yJk2Xkwn0Hutj1JfIAXikIt75/pw00wlLyR/po+8lz2MTDoLzgJbK/hJu4mW3GzEqaL6tAi7etC3oVgC5IlaPw2+nJvi2PqA6lVsbAhcypVbsAmp2U94cMlTPofbV9nOlYc2/w7rQI9KWGMhCdU6VZyaEmtvvWVz1ZXJBuoGJC6C5CkLIGO4JTogWdsRsXLtqizLEhmJYWY/Y8HySVplLilqBG0qH+5KCQACjio/vIlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fwdgFpqT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fwdgFpqT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJ19r73xKz2xd2
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 00:54:07 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-84830c774a0so913322b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786287244; x=1786892044; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/cw6oMGvUHB+hNpkuOSeNVySjC3l8LxiE9FdEJYQLw=;
        b=fwdgFpqTIJ7QxnzE8VeK5CJy5uDXj73++ZulZPoUwbpqMsVgdjugzEj2u9s21Js3ub
         P134mxU3Ely4bns13ZZnZOmSX3WL8mbN6aujiRC4dGfgZm5ODWIMhvNqhqAGBpDuwEBw
         SjSaTCWCtCVZ3YIcmT5B9v0wWOejlygv5wHNL6cXG7pFiULM7oTTQny5N2z99lwSOvKD
         ynFw9Gdp8iE4hCLr3cWatTV+n9WJjERAOOxPLk0Akb0en+9URy2D2pnvKIOP33gJ6QcS
         VynxVdh2pHKntK2BA7Yl/YRutVlIMvIuZTk70FA5u6JRaPXnzIm+/Y/llZbhcfp0fgjn
         PTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786287244; x=1786892044;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H/cw6oMGvUHB+hNpkuOSeNVySjC3l8LxiE9FdEJYQLw=;
        b=j2S6NS/m+qH9p1UtiGFpezNwRHTETqwECD9wp96aO2y1vOMfkFBw39/Y6INnOtwuAr
         izwxjgnbNF9K9DnayAbUEeo+NZ1TonroYJshcysHvFbUilvKTK94Qmg+Futw6MfzsveK
         rjvdf+LEv2WgiWBKjJT753NOANBK5HbEobGZqYUaSAgpBCrbqpPV1eu13kuQDlB1VkT3
         Jh625iYWGV3Cn54QfZz+AKHUXZnz1urUbXZ1OhnowrWcBVn8Q9NqJcgFaMzImu08spDp
         7VD4cKBjGn6oxEET9liK36Fxad6UTDlyzTVXPNqJvQvjHUmXIY+TzeDkDOr5CxMAx2z+
         GcBg==
X-Forwarded-Encrypted: i=1; AHgh+Rpq6pKXpgrkbUSsImQlgQq1qPnU/veDIWAKA5jwlocPp8wujF8Dt0bh1Nhrt+uo8k2VASL3vaUiVaTIDzM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4bCuOFk/HJip/E0fWpi8Vhabh+zAOK/ae2Q8/LSVaqxH8vTcp
	LwNJ2guOx8bE07tk9iOazCLq442weyWHr6s+0leAEvoKA3Tl5P58GFqM
X-Gm-Gg: AR+sD13jZhZ3ksBTJZk3ygZdRnvn0nqiJBSxDoj7y4l8X1djk57rkAKxjZ8hOrQ36fP
	BV8qduuUwNdxeSeAa2fRfs6a7SZ3oX9n+2HJ+mp5djhrw5ea1BdpYSeuV6IC0AZULyNjBPQPd3o
	ddV4tZqxpiPq2vRtBXBlI8G2sA9nibyv1qBor/Rao+1UgYf7TsCPoUd8/k6E9US9ik88jErXK9g
	LLJHkie4k3ydQRJD4SD23XVOOuZS6aT1vAdA4DVpPtTYL0AUKNCjD4JARoqiN+Xeb61A9RH0Gzd
	ispJk2VhpYqsxEl3t3A8AJ1Hj8Ee0HtErXUrbBT5bWwhMqQbDh7w99iBrwwKMRbZc+GvrriVVvc
	mo9y4tR/VonrTPqTDH1KfVK3o1XfuXyGslxbEO4YKcOzJODVA+y35wnU7rrkNHO9TSf0e8l6UBr
	bqkUa5WdEHJFI8MjnYeGv9EGmHxzT0/aLUys9XFEuqn3yjXczYgI12nD1kB8v8KTTDHy+LAHoAt
	gsiYoyk456Nq31cY3TJph4USCIPNF0JPt+Nwg==
X-Received: by 2002:a05:6a20:e593:b0:3c3:fb32:a004 with SMTP id adf61e73a8af0-3cbcea16454mr15497371637.34.1786287244292;
        Sun, 09 Aug 2026 07:54:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e90asm31456515eec.3.2026.08.09.07.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 07:54:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ccd8fd7d-4555-4ac5-ae73-c16e98b8edc8@roeck-us.net>
Date: Sun, 9 Aug 2026 07:54:02 -0700
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
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ
 lookup
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
 <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
 <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net>
 <CAABR9nHu4pt-Rg8Aq0B6KfKFHX+C1xQmMk6=j8jq1Zn-MQ0p6Q@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAABR9nHu4pt-Rg8Aq0B6KfKFHX+C1xQmMk6=j8jq1Zn-MQ0p6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/26 03:01, Bui Duc Phuc wrote:
> Hi Guenter
> 
> Thank you for your review .
> 
>>>    irq = platform_get_irq_optional(pdev, 0);
>>> +if (irq < 0 && irq != -ENXIO)
>>> +        return irq;
>>
>> This is still wrong. If there is no pretimeout, it does not matter if there is an error.
>>
> 
> If checking data->pretimeout is required here, I'd propose one of the
> following approaches
> let me know which one you'd prefer:
> 
> Option A (minimal diff, keep existing structure):
> ---------------
> irq = platform_get_irq_optional(pdev, 0);
> if (data->pretimeout && irq > 0) {
>          ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>                                                 "wdt_bark", &wdt->wdd);
>          if (ret)
>                  return ret;
> 
>          wdt->wdd.info = &qcom_wdt_pt_info;
>          wdt->wdd.pretimeout = 1;
> } else {
>          if (data->pretimeout && irq < 0 && irq != -ENXIO)
>                  return irq;
> 
>          wdt->wdd.info = &qcom_wdt_info;
> }
> ------------------
> 
> Option B (check moved out, before the if/else):
> 
> ------------------
> irq = platform_get_irq_optional(pdev, 0);
> if (data->pretimeout && irq < 0 && irq != -ENXIO)
>          return irq;
> 
> if (data->pretimeout && irq > 0) {
>          ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>                                                 "wdt_bark", &wdt->wdd);
>          if (ret)
>                  return ret;
> 
>          wdt->wdd.info = &qcom_wdt_pt_info;
>          wdt->wdd.pretimeout = 1;
> } else {
>          wdt->wdd.info = &qcom_wdt_info;
> }
> ----------------------
> 
> Option C (default-then-override, only look up the IRQ when pretimeout
> is supported):
> 
> ----------------------
> wdt->wdd.info = &qcom_wdt_info;
> 
> if (data->pretimeout) {
>          irq = platform_get_irq_optional(pdev, 0);
>          if(irq < 0 && irq != -ENXIO)
>                  return irq;
> 
>          if (irq > 0){
>                  ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>                                                         "wdt_bark", &wdt->wdd);
>                  if(ret)
>                          return ret;
> 
>                  wdt->wdd.info= &qcom_wdt_pt_info;
>                  wdt->wdd.pretimeout = 1;
>          }
> }
> -----------------------
> 
> Let me know which one you think fits best, or if you'd prefer something else.
> 

I wpuld probably implement something like

	if (data->pretimeout) {
		irq = platform_get_irq_optional(pdev, 0);
		if (irq < 0 && irq != -ENXIO)
			return irq;
	        ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
				       "wdt_bark", &wdt->wdd);
	        if (ret)
         	        return ret;

	        wdt->wdd.info = &qcom_wdt_pt_info;
         	wdt->wdd.pretimeout = 1;
	} else {
         	wdt->wdd.info = &qcom_wdt_info;
	}

(which I think would be a combination of B and C) but ultimately it is
POV and doesn't really matter.

Thanks,
Guenter


