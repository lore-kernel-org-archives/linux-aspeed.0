Return-Path: <linux-aspeed+bounces-3522-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27A2E9A04E
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Feb 2026 23:06:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGXF40cnxz30M0;
	Thu, 19 Feb 2026 10:06:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771413285;
	cv=none; b=FR0bqI5HMgvhuIQlKuoo/TEvY8LiogaT2Iqu6+dGRXQjFpLs+R/9D5jxE5DL2QXkBZvv/SIwdr0nQ2+YFg6gdtd3FGusMqkBbLXSoOemv9liUN718vIUaFtvC60JlaPleKIaHto0mm4bqTk4Q5te2jRVPpxPU6lGLUxlqC4DZgFLZY955JpUvVgI0FEl4MWvmRbUPwyq3zywhYMQnoLil4SWg54+LoiolIf8iNgDFT+uY3fy9+CjIVH4c8iSqvtYGBmSvtCizJ5B4fAnipuukoLX9qiVLWh8b+G3gLAwmj7EEJawd2RhmU59RUFhm7+h77GtCZ2IY0AjJZq9wwN+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771413285; c=relaxed/relaxed;
	bh=2G2U1r6MNxqXWHe+KrJPIT7PkZtApRJqJedGKd+iJpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fE+Om0rA4M6e1aBqFAIB4rO+C6erAsOhmqYRw+gijsU6UQTvbtWydmNT3jeEDkDObwIVbFwAivOMOUo7EDlVoAoi0OOeVjwkRX4W41gwpUnEUj6oYH2ac7QrJPc0r0MUkknV7BzgNf4/PR1KtPZxRjwnhhqMuJ1cmRy8Czb7y1o4hXCLTL5ku3Z/DncLOJTL/S5/dj41ZEzCbL32LRGIkJz61thLsJ5vVibJm/ZQTVkF1wkco8KwE2+ATtKZbtWcm6aZ4lBi/ilwjAzmu1h/Vu3BbWrGZKTDam/wgkPk3zxWgMr9WQUZkJ7bidBabJ/wJkZr1PMhrCuuij1//mpaQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FNCh/Ovs; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FNCh/Ovs; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FNCh/Ovs;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FNCh/Ovs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGDS33qgcz2x99
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Feb 2026 22:14:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771413275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2G2U1r6MNxqXWHe+KrJPIT7PkZtApRJqJedGKd+iJpc=;
	b=FNCh/OvsxqwMRQeZYeciFWxkjkuN2bBM/3I87+isiOox13zzHLTmhR98ukTnddVSyZ1d4t
	5xg6+XMZQBDq+G8upMirvFWS9p6NTofUQSbLl2uOMHRr2otm5lcMwWDDWq4WIfpbnup0v8
	VdW6VMIAp8kqPJyWCfqYSXrIyP8faRw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771413275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2G2U1r6MNxqXWHe+KrJPIT7PkZtApRJqJedGKd+iJpc=;
	b=FNCh/OvsxqwMRQeZYeciFWxkjkuN2bBM/3I87+isiOox13zzHLTmhR98ukTnddVSyZ1d4t
	5xg6+XMZQBDq+G8upMirvFWS9p6NTofUQSbLl2uOMHRr2otm5lcMwWDDWq4WIfpbnup0v8
	VdW6VMIAp8kqPJyWCfqYSXrIyP8faRw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-V12M751dMW21-ebtTA3fhw-1; Wed, 18 Feb 2026 06:14:28 -0500
X-MC-Unique: V12M751dMW21-ebtTA3fhw-1
X-Mimecast-MFC-AGG-ID: V12M751dMW21-ebtTA3fhw_1771413268
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c882774f0dso3283628385a.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Feb 2026 03:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771413268; x=1772018068;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2G2U1r6MNxqXWHe+KrJPIT7PkZtApRJqJedGKd+iJpc=;
        b=k7eDdOOC2O7Xjg8b3J55ekOwcOmhQIqDBGuY9P7NUQfP7ydg03rnheuNaF3BJsQzep
         BnXjpFd3DLJyaR3BfYXuPUOG0IeG3/82qqchK7RwQfKcL49Zt6Mx1mGq1ZB4iATLZe1H
         iSOWTiqUUyukd1IsD+mz/cAeEwQgJ7lmFXngFPHO0E1cyW5MNYJ4S4rjF/BoMc+StPSk
         J1Bzl6ATQ1CHSP/NM29h1h/1fHPN9qEKlLIimnnrDt0ZvoGP440kwdDfx9eIflboAalu
         lpNLOEyMftmOgBemFyQinzZ8goiYQqbK/p9KW5bl0ZvSAs2g13MylUCBiCWO+bBAmUCW
         FMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUDsUeLBfDjfP1HM0SEq5pUJBLMmGlsNZl4XGTCK1YxbRjLo82moywyd7saGsAo1YS82TpwmbUKL//RoY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpH93vdaguF0ZtUB5mZQm2K9h6rbzV89BqJPRIROUmysNVJPKL
	L0gPaKUkyfQvDDR7lxrtSjQPg2anvwphsuZ5qXNUCtPMRbw0Te5Z08Gbc9j5ZGMtkiBc7leWOaq
	Efx9SjE6+ebP9ASAkjxdsLUhmePuVifCNEDoUD1WJbVo575toSMV6HNTR00ZlJbfoXaU=
X-Gm-Gg: AZuq6aIFjBVa/fc9sWA0bJbiuzZnqqsujd7XxP3ujcDZBEmFPDCZRg3IgYHBL6Rrnqo
	Wc2z0fZpBHGdzU41Gxy+tYNYT4zOgJHkS6oaQeW34M9+AkAYqvTt+/aj7sOViLihNioUNrF2wf2
	aqLkxvQfbYTo03PNj3YwGCTv1nTKsaij3oqnfzQIO7M8uIA6fvrker8J11yW7isAviugWiemis5
	Z0zyFZchxkAC0xKGGcInPhkhXQsWXMmmVVCF4MSgm67HXzMKgLBfxqgQ6x9mgOO7VBEgE2gBA40
	SgRkuHP7jaOJckpe/f48UwjoMqHbdpEFgPmasiigRKXZjsoNuXaQ6ZYUszrzz5s91Tscv/Jw0rj
	bleYCqyBddHb5pJ+M/pD7iui7htdsTomnw6qXnHBVQREneX4La/7gZtST
X-Received: by 2002:a05:620a:1723:b0:8cb:4289:6c3a with SMTP id af79cd13be357-8cb4c01f4e9mr1744950285a.74.1771413267747;
        Wed, 18 Feb 2026 03:14:27 -0800 (PST)
X-Received: by 2002:a05:620a:1723:b0:8cb:4289:6c3a with SMTP id af79cd13be357-8cb4c01f4e9mr1744947785a.74.1771413267191;
        Wed, 18 Feb 2026 03:14:27 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0e1bdbsm1749411685a.17.2026.02.18.03.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 03:14:26 -0800 (PST)
Date: Wed, 18 Feb 2026 06:14:25 -0500
From: Brian Masney <bmasney@redhat.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: aspeed: ast2700: Add missing NULL pointer check for
 devm_kasprintf()
Message-ID: <aZWfESmMIw-e81W-@redhat.com>
References: <20260218-ast2700-v1-1-2388e0fe3597@gmail.com>
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
In-Reply-To: <20260218-ast2700-v1-1-2388e0fe3597@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qP7vhjgwA6aMC9mC6W0gI8x0qLTuJxrFmpoXEHnYWHY_1771413268
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 18, 2026 at 04:16:37PM +0800, Felix Gu wrote:
> devm_kasprintf() can return NULL on memory allocation failure.
> 
> Check the return value and return -ENOMEM if allocation fails in
> ast2700_soc_clk_probe().
> 
> Fixes: fdc1eb624ddc ("clk: aspeed: add AST2700 clock driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


