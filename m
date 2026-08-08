Return-Path: <linux-aspeed+bounces-4657-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C76C5AD2B
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Aug 2026 00:23:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH1vf3KlHz2y2B;
	Sat, 08 Aug 2026 10:23:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786148606;
	cv=none; b=SlN42+9WLr5f6h2ZmdcYKoFRMUjtiTMm9DwPRPMVN9iIVAZ9b8qVB+oRSxXn38cunbEuwqeU6RcUx04rTqarUzsT1/Oy1Mdr+8W3QZiK0LmVALtffC4mLewCVXFja0OxzR8JgBIDGIm775DTUVLAP/l5P4AGUFmZp0hjLUGWtLWc0V8kWJ3cqYHRi6TfEC6VOHfvI9mE92wLHzTcT1J+6xrXcL41Hjmtj2Dd950rlf9qo3XES01wXKk3x/QDFmRQLpiwBOlZu4ui4YOjeEk503cGsNzOA/Tmm82b72Vg7c1xwG9d4MSvSJ8rVuanlY+vqWy1bAkf+LoPRuqgkf3jdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786148606; c=relaxed/relaxed;
	bh=Jt0bpdMVi/3j/bZABoi0jP8ZxqRZtLjg2lc4An7moT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jj1n3CyN5iDYgPta/20lKkIvdDcBbpah7WX5E0o4FawVWSZjg7vsBZwgy1V446RJ1IY+TlRGIVbGuham7toB/RWvHU8n6mD2oQJOf8zw+pESg0TV7K/B4ub3/x5T1zkD4mA+NIypBHbzPBFDw7zVjfIOTQY9CFXUR6qAnCDdaJwdnL1X6f807L98Q0Du8wY7JwBSclcxhd9xdX6BmrvkuW8f2PxfbKgsUf/m+ICv/P5CP7HspaiZgrOQM/k798PENKAjrs2aTpiaY5zs7mald8DB7At3Kqxd+qNq79Ec4TQp+wWk5hSYvHLKxAu/XbKpu/1JSGe8gZCdrqTKzOANPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OcxouRl5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OcxouRl5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH1vb62KWz2xLf
	for <linux-aspeed@lists.ozlabs.org>; Sat, 08 Aug 2026 10:23:23 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso1215975ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786148600; x=1786753400; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jt0bpdMVi/3j/bZABoi0jP8ZxqRZtLjg2lc4An7moT4=;
        b=OcxouRl5p/goNC8L3wNNnCcPwWXFmQb+XVQ8lxEpNa/+1UVg4jxE1thwncYfMalR9R
         6yhqgJlQ+tM+lnno1aUObWkS94Jc5xGNNy6rf4u5UtvDkD8unoaCofhTbzySctwRpUpm
         2X93mLwOhFBUC/EuwpZFZb/k/zcyf9Teg8gVlgneFbGYJYx87Ix3Bx0outraGpPOcfZZ
         uUwjQ/aYjI+7ukp6FVWjKWQP1Z30Bg89KU3Ie47ZF7r25yFASdhOT3zXLBLlkqYeml8p
         647gPbrstHQ09U2pYVabkfepr/AAUZCwSs+cNwf3WitiJwEPpckkc67IZBH5yFmWjwaq
         TWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148600; x=1786753400;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jt0bpdMVi/3j/bZABoi0jP8ZxqRZtLjg2lc4An7moT4=;
        b=k6D/py9uoU/2N2oM2gFmSU+8nIPBzA6quQi0xmGKp62gIn1+Ou+L9WgPDlKeKVAdSu
         dn6Ecn06SJCyIQfWlI6mLhv2Xhqw+/KmVJRctoX9JfuDsxMrMGn5QZ88+YFrEyH80kJp
         yGmVXtrMuwBMrVxKb5FuPEmkoxlo/JoHmRStgv3aHH7bXw3wgwLT3DVTXrw34y7SgrBG
         U7RF+gKTTwKUFJ5kICp8ysl6he4bFLEySTvIz/8w3vPHxTvBbuKYTIIq9WRTv33onW3x
         JulZcPukBKz0zrQ+9Qsz2EV+vPzkZrNjw8BAOAD9sQ9PXvDU5jmYu8Oc9GN0tAWHub8a
         8Dpg==
X-Forwarded-Encrypted: i=1; AHgh+Rqgn54/u+3TbDounXJHHXbf7kpN/Fgo1SZl/yfySKQ/HQ6U/Ns6DF2TgbWrxgg/MMlyPDg2wcv0yaW5j+E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoBa93e9qynJQc5V7BXBI5nSoKe6mCWxhmlRLP0VTkJS2T1S42
	lRqDhhj8h+PZGNaQMvqzRZQuSh9nbx+JXyin/mUzYk0WebT3yjwMofFA
X-Gm-Gg: AR+sD11lIDj3DS3jcaJAPICK88rkQ0MYtElT1C39XcgGgRMk7YsNxBZBkWq0x5AGsjD
	d9mJKAp5rq7IRKD54/PKvb52eJFSHzRuLyVV/y9brv3mLfHraXN+FiJBCRIaCZORPud3GssvYb4
	6QSA43UGjDbGrDXZJtNZPQSln//ZQ1O0dVEm+hafjs1EB21zqWaKbts7nkiACrXBOXG1Iz+UaA2
	B3dBAsKbYwIa+pMpiK/m97n6nQ1Z/KHNsShWW2cBC6rHEz0XJnjV6qSJm9FmtV0DGLdbSOp1mwo
	inSvwGtSur1ohDj+NOzIdanUePpofuLV9baAa3iVwKqurQsXZyETrBx+8UeuooqQI2/z1uagUqE
	pVaOZiklhk5c3OlMh1SIhWm7GeLwPAmAcxcUWkJ/UrOrf40yKwnFjQ46zxSnKpvBnshEMfnLLhD
	N//lABJDdjY405OgYiV2/VlPWfAI8R2BbaWfZ2xg4J7ReolRDNRblvRewcMSeBSIAlBnNwW53+R
	C8ojoMmRCuBNQW0fU8fHVh9kI2TwCvpbi3HuXnQftuXq42D8w==
X-Received: by 2002:a17:902:ced1:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2d106a1a2d5mr146246905ad.4.1786148599808;
        Fri, 07 Aug 2026 17:23:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4e7e89sm14214285ad.74.2026.08.07.17.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 17:23:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
Date: Fri, 7 Aug 2026 17:23:17 -0700
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
To: phucduc.bui@gmail.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260807081652.38692-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 01:16, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Instead of only checking for -EPROBE_DEFER, propagate all error codes
> returned by platform_get_irq_optional() other than -ENXIO, so that
> failures are properly reported to the caller.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>   drivers/watchdog/qcom-wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 49bd04841f0c..a8eb1d8f24f0 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -298,8 +298,8 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>   		wdt->wdd.info = &qcom_wdt_pt_info;
>   		wdt->wdd.pretimeout = 1;
>   	} else {
> -		if (irq == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (irq != -ENXIO)
> +			return irq;

This is wrong. Check the if() path - the code ends up here if pretimeout == 0,
even if irq > 0.

Guenter


