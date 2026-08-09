Return-Path: <linux-aspeed+bounces-4667-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF09C5AC80
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 15:02:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJ1Mv19zYz2xyl;
	Mon, 10 Aug 2026 01:02:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786287771;
	cv=none; b=Kdwzoc+cWNpQxLZbc5gXh1VA6BNfTKXhsH1mi5C+uCObPRDOM2xudZF4voj9cN4KPHPbZjqKNZke3RvpAx1yR4div3D8YXerLoc9J0/Z1aTpvcvBkb6U646RzNhxQit0Dq6bhcDcmYNCz7booYZmY3WwSjZaH9qojlJjMN2Q4E77bMgc5JZBDVBJUC81al8KTzgg+ew9osPsDwroTTJRUsxqplpuShHk3vVJzqWgmYZFT+pWP/lSr1txLDUzGA0kABM5/xfUjJfyQWedk8vURF4GQRuuRXd9OUaidi7MO+HMDMEDSdjwSkIexcffVB1F0HrX/lGQqAHPkx7PqbKTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786287771; c=relaxed/relaxed;
	bh=f2Ph1N2YXDcF/EsJKreKtP+YQA5yS18iu0pKlYJPT7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4/c1FgNCS4B3dYc0AHs5IasGQIEF6YSqBt0y2irNzWKHqwErj9Z2w24fFtrq6rd6UxXMMC7gaB/bpv2ZeOH02o7lCdn4j/WWsSyuRV5nHVcm10mfJmkZkAQfKUltjt9TAEW7yd/72mVFFJnUk4gm7r/pzOB2hj1Wm0GyRxSv1K0kwU7Gu7ECOYeSg9+jsVDjMqnIsTnbr9yo/bbqvuBAJBFqp/Yx9OW7c3adgGK/M45zEFz5l7+QSklcuxis0CYjn3Z5qMOSk9c/YqD/vE/FiOs3X7LEccRkwT+zZ+rwJQe/2OVUwpmhj6oNvd9jD2NnomBqhNgfpHn8fd9IuF/Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BKGliE/j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BKGliE/j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJ1Ms6KSLz2xd2
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 01:02:48 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso661859a91.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786287766; x=1786892566; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f2Ph1N2YXDcF/EsJKreKtP+YQA5yS18iu0pKlYJPT7E=;
        b=BKGliE/jYwizReWHcXio7pTN19GD+OEtKiHaD1NLBzzEFJFxkqLsKC5BfSn924jEJX
         XM0sLY/vfI1hSLjzPlE2pHHO/HX+PAiTh5IR8v5HVOqxb5yNnfsW520i28JX0UbtNC4O
         fDzZDQlRRYoZRBe+dmNt41mUpr8LXile1SSHJTCCMPptu2ZH9ZAWpXnokx0sH6sAImOF
         9aWNT/9M0u5ZGttrFGsheu+0pQT0UJAEzDYjOs7g2evw4IFeINbQug3QscPBs2uWAeDd
         iB5s7w8pfqPmPMaT2Qc54KaaIakHfF/f1DbjalfsbzypMR7HwzUIXqgsoh7e4lubpC+s
         TKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786287766; x=1786892566;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2Ph1N2YXDcF/EsJKreKtP+YQA5yS18iu0pKlYJPT7E=;
        b=RjOUhidlhVOHMj/tmspG0XsmtK2tihM4sbcQZ7rCBmWt+WB+5sIQm8ox2ZRwWXfQp4
         eQhG4eSQTOupDl8NRFZlqG5qscovuK+65oFJXCCO+dEdHK2t/avQbA/PzbN0Cj7ZbJW3
         T0LuksVzr9wYYhkrvcIxQEpzldIMjSMxyI2VPZff0wEcaWLE0khNUcDTpexJ9njeg7g0
         r0uarDOZictPhVbpvG999nLV5nWIyHIor/RVN/pzwK7OuO7I6I2KeXiWeJiRE691RaVW
         7EMXh/W6HfPqBma/kReTBcsHA7ZXkPT3w+UNUA8XqJ6YFaNqL4UixFVQNKEMmO7W+aAp
         QcNA==
X-Forwarded-Encrypted: i=1; AHgh+RoFtJOXmodbJZhpHU5KfUQlHcCFVMMaqzReTw2k1LdlAG10Rw3i8BShz0khHDI9nHsBmiqUHgEK1LBVlmo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJjzlewHFLg9dgeI7ReBxWxzmeRbAOpVt7KKq38SHHaPka0ufy
	3tM2ZZrjwO2mYHHTTIRHEXj0CzTaRGOGbzm4+u/EInooXCOgBsbsF7a6
X-Gm-Gg: AR+sD12IOR1FHZdTYfTBV62GVoottbFPzt0n5B7b8JSJmxIVb6Ax0EkQgfPSxCudAE3
	J1Gch5JLZJxDLfd4EfL26l1CcLOLwqL3AzVKKatlVUkqqyu8pkkBqn3n3H4p/rmmX+jVL+j8g4G
	DmuljIJfgv4dZFwxC4BYKSRvneg75yWP2ldIsZrwVaD+oOGJZJ2LZqdX7efz9FKO6A+MWWQEtX7
	rbrdnffHbJTFnvTMNlhGJHn36ZE9FjJMNqsDcZOmB00GXlSA2U/cj0SgxfFEQDaK1SQisacWls6
	DFpZ+4pRkmY+tQzT8dXJRmGIGQgZzgblcn0pef2VDuWfHjXnB32Qzpq2KzPwjnoRNDfyDbk6MSR
	li67zdEiHufR0Y1GN/twf/3oPPwCR5/zPMUu7dRFPpojN6ZW8IWmVlSPjB0KgiuYixaauVMg5Cn
	Ctiu8ow4MBkbHOr3x6vsjGd1zK8o1ldIm8La+A9ER6pj1zs1G0SnCRIiVOmKoGRdfAnfWudwNZG
	rjHC+pppCHK
X-Received: by 2002:a17:90b:258f:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39282247ee9mr14215543a91.5.1786287766154;
        Sun, 09 Aug 2026 08:02:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b41d9sm25594852c88.5.2026.08.09.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:02:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 9 Aug 2026 08:02:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: phucduc.bui@gmail.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] watchdog: mediatek: Propagate errors from optional
 IRQ lookup
Message-ID: <4a875307-19ea-486c-923d-78a362651f60@roeck-us.net>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-2-phucduc.bui@gmail.com>
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
In-Reply-To: <20260807081652.38692-2-phucduc.bui@gmail.com>

On Fri, Aug 07, 2026 at 03:16:50PM +0700, phucduc.bui@gmail.com wrote:
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

Applied.

Thanks,
Guenter

