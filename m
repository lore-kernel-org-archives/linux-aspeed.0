Return-Path: <linux-aspeed+bounces-4669-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE15C5AD4E
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 15:05:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJ1RQ6rzgz2xyl;
	Mon, 10 Aug 2026 01:05:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786287954;
	cv=none; b=L1e75U42XZaA8FTRKpPu0FC2Kt8kOIJaBhbSsy8ivFPfhBeeby6aY8+AItWk89PDl/t7+9tcjW0yRUYPH/8vYnbekQXjy6cyMN0CoQ/dWRTH1erJK0jL4p8OyejOH5FzKam3pGbheYKbbfP09NnWuSZQsx6rJ/PdmrYio1EawFxX/wJ62+T4UuN5p1Vl7QQ2zdO94WQaUstpHAQv2tvy0jcdovLCuBUXjF5fujeUobxoL3XeHmnpWvdxvl0SQ9BrrLBWFWyYAhe+tJthmuHjea3d/duvR3PhSpBKw4w9Pv8hBFp+ayIPEtyFivyzA+Xm6KHxjvUBFkLyH53REzAOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786287954; c=relaxed/relaxed;
	bh=0xMkbVk8Vq9ADk/FsQY03JHzIZEPQoL7wUy/e23YhPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3N/SOfiaaJj2W3G7TpWiYa6nWP2/8sZQGvDsUR03ggV46SKpdR04CX1QkUiHvFdiVyTMd3nlSFV3IYhItmIl7bB4BmfVCdgj+Y/OxyvP0t5asRPT2ySgjjl7FEri/i/GNz3o7OaaA4s7z8+oEVxMdfdI+AjJkxUCQ6QePNfe/tb5lXA7IckCnP7QRL0poOMASgAxsJ0HaYvQU7x5FlMbv76kR8K3EzKt2OzQoZGqi5SyS05HDEIpre6sUMCuizOydVqyfG11npdFkqjM1vdHWMFt3qKZzUDz7iq4lJMOzkK2Cv8kg5Nh5W5p2iRYRYk47Iv95OCZxSWre2321hvlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dIm9nsMk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dIm9nsMk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJ1RQ0rnrz2xd2
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 01:05:53 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so926705a12.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786287951; x=1786892751; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0xMkbVk8Vq9ADk/FsQY03JHzIZEPQoL7wUy/e23YhPc=;
        b=dIm9nsMkJuHhq5T59D6JzOLf8JEqT0w318IM1VV0XHl7qquRH6PFmIs4eGS9SOwncn
         gfsVKcNjVKSUYsWKmaYIiipsqdEsErYg1oyJIxqBkPXjE34sySGDlF38aBgn39hX6EWr
         Vgwv/eTR9Rth0JEWsQVZ8nlKLDBPtC8nYUyYNVjEyM9d5MfzuvE4ASSLkW5QQq777wqZ
         Kp55IiZMiLusj/9VXANNKGFM+tR8usxBUcAm/r53S5Y1QdUySrbB868I9sWgqVY4f2a4
         uJ5EIFCY7nRygbavMqR6aqfxJbJ6+tmOZ0Ik07pgqVYa87E8yaiqt6R9KMJae6JHdQPq
         m6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786287951; x=1786892751;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xMkbVk8Vq9ADk/FsQY03JHzIZEPQoL7wUy/e23YhPc=;
        b=VTioqurn+8NTNH7x2UmzDLvA0PdS3dw5iuKvKYXkkLP+vqzxCPlO3qQ7pUY/0+vtgi
         EuyDw3kCn6v43vH420iilBjX/vbJ5A+mGaisDkTXV0YgJOjt6AAPIw5awGi5FZ0OqnuG
         81dvtlIWLR1mVtpWKCBiBCD9UAle/nCNG2xiIFoveYjz6fEopwtgjNIiwwptQRmi1RKB
         JF3IZJV5vfyqapAzqPiyCMJOezq8x0Ph+f1+K62OqKQTbb2Jj9IIGiFQvs2O6do4/flt
         4wADG+dXinU49GhFBlWlvTwR5xCu9AbmKS8QU2uCX/7tj+jftbcQNbb7ihgP29X5yXD1
         ovxA==
X-Forwarded-Encrypted: i=1; AHgh+RrIZTvkuQAVE9SOmT5Tj8fyJU6bIso2KSja9p6b0+jyMTDtwSSupXlajobpxaffbh58ijD6yG70C2uFi08=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxlTp574N0IYmycz1lg7WCo9xNgqtRuItfhGJFQcenhrSMASvq/
	wLLaB9n+2jVJSTPNgbetFHU4OkpLBTO+czOzeOIWbX9Ws+ZCmMrwgIoW
X-Gm-Gg: AR+sD11kPt01HBBexx/mR7HrGEOsFWxaneIKG0ZsK/cvLgCAdSo1uw5INYx8yNiEq2z
	e5UlZa2MB0Yvl7RYF1XiayftTRZTx23Xz/Qc+Z63HEGDnp9KGjLIzBvFzFe5uKrRHowLGShqyhb
	bZ3j14S5EdlNeETh7F1XXxEJ6nrrJTFiW91Xq095uo+8IJgiqfAoyKEb0QwO32lshJi5smju13P
	fc/3+4ve07OKzr2VLZFAi3UPDbyFhGyRUf6D/75Mf7X9wH3Q/NSLADXJnAiPp6bEpO0VS1IBNya
	Fxxo+FoaTwuTsfV75PSeQHYE2NFUu0aYnfiMnZxC18QUZOoBZZNLwN5qOBPgukQ6+uYricSrLqm
	DWGt8tp6mZ3LyWzaw5F54nI+qJseIvo7Qfua7Fn51sC/u7frxBORHWiqdBA7ruBNKAvgPQTpicF
	x4mQ2yNwJ0JxEQZXyW/1kLthUF9m9QKkJ3XwIpIhbLX2cyDRHcmmj1o6Kj6HkvMY+iNSVLaFLDb
	A==
X-Received: by 2002:a05:6a20:9f09:b0:3b4:8f57:3205 with SMTP id adf61e73a8af0-3cbc04eb981mr20974725637.36.1786287951463;
        Sun, 09 Aug 2026 08:05:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm54797483eec.18.2026.08.09.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:05:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 9 Aug 2026 08:05:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: phucduc.bui@gmail.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ
 lookup
Message-ID: <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-4-phucduc.bui@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807081652.38692-4-phucduc.bui@gmail.com>

On Fri, Aug 07, 2026 at 03:16:52PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
> probe without the IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index c9e79851504c..48454ac86074 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -429,6 +429,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	if (wdt->cfg->irq_mask) {
>  		int irq = platform_get_irq_optional(pdev, 0);
>  
> +		if (irq < 0 && irq != -ENXIO)
> +			return irq;
>  		if (irq > 0) {

This if () is no longer needed.

Thanks,
Guenter

>  			ret = devm_request_irq(dev, irq, aspeed_wdt_irq,
>  					       IRQF_SHARED, dev_name(dev),

