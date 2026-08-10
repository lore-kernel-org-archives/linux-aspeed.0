Return-Path: <linux-aspeed+bounces-4676-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B828AC5AD55
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Aug 2026 14:24:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJcTN0lkPz2ysb;
	Tue, 11 Aug 2026 00:24:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786371880;
	cv=none; b=egjpJoDB/tMmMXNdxFJDkKAXaesmOB2o35t4bTL8OeJHjPWl8lfSf5g/9JEaL1a+3/PBLUniyzJzArCecE7ywEOg9aoBZc53oD7ze8+st8xd9nIkXSQYC5ie0PoNcdWcvmZsqtN8IUg/T9X2JparFFifTlcEyLKwWqYoTMt+TRiGU+/MRDULgzH6kGty80Q1QQ/2w9gUW4z5SvIswfY1YGHiy7N53nCbMDjWG+c8Rq7SzTXOHPgQsk6+iw26Z+I2LFONrOY2Gxr7Frgydop6GxTl+gLk+CO39IUzwwrovA7VyG5CJz2Vc1RQrNoslqnaPRUY2Ctwz4rSZexDXTMFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786371880; c=relaxed/relaxed;
	bh=5ax2GIMqI2oJHn6HgwhTWHhHEkIAyr6Rp1OTrqHHWbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL46KRzeD9a815TuyYB+3pMOuY/dQqFCcTicz2VtoFcMss8HbY5IcboTnLrufeJmxKxpu8bMpyNGa+7NPyo4yHchc1/Mc4cvSw5F03c9xiSRWSS6VzZTxIhKcFdpnk9m35lc/KHxnG50I0lD4U6OAxeK/q88ql8i6npJj1sV/EAoIKGV3uHZBsU6xIT8nsSguDWMgSkNotpQfIkDtwrV32NMRplwJJ3YCwsDVVd7MAwRDc+NI3ilNHtVqon5K4iEW6RMxo/rzad/aNTwu26pGfxgsK7NRTy5O76cBfa4ZFwI+x1TR3x3ZBNIsz73tEKn5JOcUwsuvH19oAXcNIC89A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QZarqXKf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QZarqXKf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJcTL1J2zz2yn2
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Aug 2026 00:24:37 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so2157557a12.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786371875; x=1786976675; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5ax2GIMqI2oJHn6HgwhTWHhHEkIAyr6Rp1OTrqHHWbE=;
        b=QZarqXKfGDsGqlIP5wR/y5uxSv6pHz9ZpNKmbjx9mPCdq3k7D8w2d0stf17o4nFm18
         nQZJsvdcwNzAFUqkRVBwA7+F2hxlwJtEJF+wlEegLQ6V9q6sabo1TfatbfsQ8svwmNA7
         6ZdVibgpWxNs9VuooGZ9jrtosbQlpW8RbjLX81x2Vj6S43KQYbUmILc/qM65sRrqTGoO
         2NsCPlC5At/d21j9MQZ/hT1fyKa67gmJgmeauInZg+meqVsR6rQQ4WPtflHd1Mes137+
         kp6yr6yfY4uMrMCS01Gc2OfuGIEMWjeG77B8godxDOxyfCtTnJDcPPUcrERxoNTd0U/e
         NDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371875; x=1786976675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ax2GIMqI2oJHn6HgwhTWHhHEkIAyr6Rp1OTrqHHWbE=;
        b=ATGPMwk2RXW1yMlZ2qVOHZgF3qSqdbObygen7SpdS1DDDEXWHqzX7ghxbQQtVaowHN
         Z+KXHtp0lec6M5h7/Ty8/eg3V8AxIW8/p4wVHbSYfvLWmQj7DS7jHH/r2BXW+N5E565N
         gGTVqTNXUojecrmE9AvMRIsMarm3R3csVqgG3xo5Z966eNuTUh/aB/84G7DyVOS9ajwr
         p9cYggMfEn8YTe/jM9knE0+DwojEEEe3aszxpENzfwmMIqeuBRhuTVsm7tkHn1PZ/8w5
         vppNHEQTcWEpo8UJpfE1FMrhFUaf78elpmr1ATY2DKfik/AshWUquYhxC9vAuH5mMvsc
         vK7A==
X-Forwarded-Encrypted: i=1; AHgh+Ro27OW2DcBk/P+n6EeCZjtBC+ifm9z9qUmoLngYFun5s1HqUepjaB8T3yZ2bfGWG1xI9uDSRwtPIK4WcoA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyng+i4S/HGolyrCRdCYQHTr7WzgPKbmEXY/jvh2nTx3vd991rJ
	M8E1bo1SK8u5mzHHFHGQ9qfCGSYOZ/pmAO9jKsG/YbvJk0AZOle3t/Iw
X-Gm-Gg: AR+sD12PutYUXsUZlEmfumcHWYJyQZ0ej91hEuDEwenGp5OtqZrW/fLeAcIZH9SwFrI
	uZNjkae1kRJggFLcVQC3ijnjgpzMYsUyymkVAfqchotWLnRjHD/sYLE8GhKZ7f2V6+RA0SHXSCe
	jcVeqtw0iAYyfop2RYc6N/sEGAEe2S0bjXGY7uaNErYmj4Qj0gFy/stoJcb5Lb4CiBNRYdoGtT7
	uAxsyKEjZjIFi9VARMmF4njczpAv3Lw22/gyuOU2nGKqaYDl2sx5cM+QQZjgbTxRJx8F7ZqvuYF
	FIGIk/55yIojl5/sOYUu+RkRUSXuUFkji6vsmiGRIjMqCEYZjOpZAO+zCbW74arLRpV/vfyYwaj
	5HxvrOO/ZcWinxa5rN7oMLzQGPYFv4smxDDntgTGcSqJdTVXLFelYsldHBMILvd8nLBea/jtCTu
	fCsbeIBeRFhj9jsRYuT79secIk/76chPbXYSD9kUCYXz1JqbpLjm7Nt6JFtJEoXEtGNeDjxLZAF
	g==
X-Received: by 2002:a05:6a21:7308:b0:3c3:a1e6:a626 with SMTP id adf61e73a8af0-3cc1a3f1658mr2809036637.32.1786371874643;
        Mon, 10 Aug 2026 07:24:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86d3d1sm46551457eec.2.2026.08.10.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:24:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Aug 2026 07:24:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ
 lookup
Message-ID: <01283c69-d5ca-42b0-a75d-6ebb07fee46a@roeck-us.net>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-4-phucduc.bui@gmail.com>
 <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
 <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
 <3a9b7b85-e6f8-429a-91df-f674479dee58@roeck-us.net>
 <CAABR9nFcitFyS_xZUkreHWp822iVsoEg6ONFwU9JwPaBqm2MTQ@mail.gmail.com>
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
In-Reply-To: <CAABR9nFcitFyS_xZUkreHWp822iVsoEg6ONFwU9JwPaBqm2MTQ@mail.gmail.com>

On Mon, Aug 10, 2026 at 04:45:07PM +0700, Bui Duc Phuc wrote:
> Hi Guenter,
> 
> 
> Thank you for your feedback.
> 
> > >>> +                     return irq;
> > >>>                if (irq > 0) {
> > >>
> > >> This if () is no longer needed.
> > >>
> > >
> > > If we remove the if (irq > 0) check, irq can be -ENXIO and would be
> > > passed to devm_request_irq().
> > > I see that the irq argument of devm_request_irq() is an unsigned int.
> > > Would it be safe to pass -ENXIO to it in this case?
> > >
> > No, sorry, I was wrong.
> >
> 
> So this means there are no issues with this patch.
> Patches 2 and 3 have already been applied by you.
> I will temporarily resend only patch 1:
> " watchdog: qcom: Propagate errors from optional IRQ lookup "
> 
Correct. Note that gmail may swallow this reply, claiming that it is spam.

Guenter

