Return-Path: <linux-aspeed+bounces-2223-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC485CA0EE8
	for <linux-aspeed@archiver.kernel.org>; Mon, 15 Sep 2025 01:18:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQ6cf0YL6z3cZ1;
	Mon, 15 Sep 2025 11:18:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757850993;
	cv=none; b=OkbSXbbwFj6FHReQ5B5DUJX+mWeyS5P3IqBLnYs/tJsPwE2GZ0kpPifIDvOO2YQyCcj4WVNl/wLykwU2sLRpptbzFMz8EAl3BjFixsCfZfbAjhyHSSMWdfQ/g/0tXHleLTKy831MPN0d8qkljKxd3+Jar0izEHQ4LDwbZ/MbV12rAZ0CuzanTyeB6wLCL+/pkeI+GK1Fp0IAQZ/yN0K/mNc8hloeFl77Xpdar1m6fYeyzIw3nxlF2RKirh0VmK0QBEZ7oiw5bgCXQgJqSK2drHMr6MRr4f+I0Er55HjqcQlhkRlA9x8IqoNFqnPd0BmuM38IIkle0Efm0FOXsY/3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757850993; c=relaxed/relaxed;
	bh=V7EEVogNqm3h2fGQuXoQvzBFJfVHtUlo6y8LaBgKxgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IyWwZIYwvT/2tTUOKud/aCeRgeDIX9PdbngdYfiROcizsmoUmKP+fXd9UC6VWY+XadsnW6g14eycg71hC3LXwdwEPjqcbjPXhq2q1qUPc+qDa6NxGu3+KPlaL+wzouyKunHAgay4gMaZf02c+Vf8SVlF4sf3CgZFx+ktNp2SUZ7PyV74IgGPld36+unhLDzW3PlPnl7yuepJzONJ1hmFjdfNxoajyQ8qg+h9L3JLSTFBFRoYRkY0GHQ5P6aHtwLGIpXA8Rl05f7dE6SKVUWpVkkxI3ND8r0EOAQi1Wd+v/6JEKmD3toPiHGb5S/b4LX46GfPhdGwltApYm4xt0y+2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZDQKRaw2; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IOevCH1U; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZDQKRaw2;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IOevCH1U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cPmpm3Qy6z3chL
	for <linux-aspeed@lists.ozlabs.org>; Sun, 14 Sep 2025 21:56:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757850985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7EEVogNqm3h2fGQuXoQvzBFJfVHtUlo6y8LaBgKxgU=;
	b=ZDQKRaw2GaHRS848UaQX7pzAZTXNAGThzUKJ50Fqy2C0oIkUIFfpN2l7lw1n7gFRgiB7KX
	3oGulOfkkvoFwJZky+OhpAtb/00lgqCNSoQKv7TuL1HzocvfHrUn49GDut40CVR1ApLz/0
	8a4xp4dPp3jm95mPNiMpZ5qAEcRKCiE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757850986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7EEVogNqm3h2fGQuXoQvzBFJfVHtUlo6y8LaBgKxgU=;
	b=IOevCH1U+udPzLC5GYXLuB6JSzGjrKzr6wFeUrPtwTIRjZrV6YiATbv4hVAM18bpln8EDA
	FMaHDazKr9/ukHqsU/698VliPuP7c46FpkXhM9gekBgAA3CFQzeHWS48OezirSrSEVuImf
	A1JgZevfKhq22eWiqRIcs79KZzDB7mI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-Ge7Pf74tMy6lDHYi58XboQ-1; Sun, 14 Sep 2025 07:56:23 -0400
X-MC-Unique: Ge7Pf74tMy6lDHYi58XboQ-1
X-Mimecast-MFC-AGG-ID: Ge7Pf74tMy6lDHYi58XboQ_1757850983
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e86f8f27e1so945074485a.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 14 Sep 2025 04:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850983; x=1758455783;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7EEVogNqm3h2fGQuXoQvzBFJfVHtUlo6y8LaBgKxgU=;
        b=ZY0Hp43SlMiCyQ2/CGjNGOb4vJWYHvzGuS3fazEU76RPSPcZaHUjWAia6L+DkS5sGz
         MUUScISzCWiVJJNTC7FlJufBItwrt0YC6503DBva3sdXFIthOriUH5q9Y/Vxh/tOr9LE
         jpLdLN8fU7LIf/fuc3IqfXylY9yOh1n7KpmHSA21ZX+SBeScS/ArqGboTstoAdl+iRZw
         RV3Lgs2CurWRxCGMZ6onBGJRxhWclB6J3OweoI/JTjbcOqkltMRNsEhfH6frW1DGUMny
         T+yhIhRQW1gkntQ33TpSxTH0iK3wuSy42lPVbK544nYjOVW2ZOT2ZKe3YRX3CrM1uZjK
         fNJA==
X-Forwarded-Encrypted: i=1; AJvYcCXDnN4TQl6Q3qIPr+vr6KpjCe8c51/DRMNg0mz7sxlfk7QFyKrLHBgalSxmnY9KkZwe5kRD32yExz0v16c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyC8XBAT7nbrz8EMtn13xFkGAZocM3eW6iAk12+RbriEPRsqEW7
	e2rf99k9pBq89A+xfSDJhbhQxda1we8s6Na8DtlbTsqk/ARgzidiziLNUU04PGPUaeDEU3zJ8fV
	FhpUd8z1FWTj1UB8thVT3MinvVPI2cfiSplrtEGgm9bx4fjTA+XVsOuxpSB5NvhF4SbI=
X-Gm-Gg: ASbGncsqHZhKk+9ZgMY8ez9xvkEmaILP+xRUbU/caiaeMIJpdPPilS4r0PWboB7ivh9
	E9SxgFSi4d8anIYPWH4I58g+eHg8IO2Hpdc322BaJEpNcS/pRIa1dLqUzchP0cLDBIqU5E8rERz
	71DouvHpFsCKwtm85jL06hj1k1D/zzdEvwJ/uPSD0TGB2ikCalDRwlax2o0QHyNNM6kt/8PV52S
	KdfRabaJwN2Ibo8CBVsr6CXgqCKUoWtGeQoqJb0Mxui6fIYRP1cqzhA0X6UfTL/LZd/vh64UUqS
	3kgV0Udig1y1KTfAJfj/t8VUG4KH6RnaCPEOhp1oJMi3PwZ+qO/kPcADtpICpMaMiIpOOMmA3aW
	twXXcQOJq9vCM5gj12ZXoWRarzUPRRag=
X-Received: by 2002:a05:620a:414f:b0:7e8:8f35:1d2b with SMTP id af79cd13be357-81ff181374emr1625000485a.2.1757850982928;
        Sun, 14 Sep 2025 04:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjgXFxjwySPCU3ek1M0DJbAsGYTyjXrUec8xKOuYaZ+ALRKNikNG6Y3NJHY97G0hh6czoOhA==
X-Received: by 2002:a05:620a:414f:b0:7e8:8f35:1d2b with SMTP id af79cd13be357-81ff181374emr1624998885a.2.1757850982589;
        Sun, 14 Sep 2025 04:56:22 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974c848sm587652085a.23.2025.09.14.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:56:22 -0700 (PDT)
Date: Sun, 14 Sep 2025 07:56:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <aMatZAX6eFI1RmDH@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
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
In-Reply-To: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x1yfhUsOFZ-DaltzuBHsF_NmlpYTQiS7L7j55RwFrPk_1757850983
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Iwona, Joel, and Andrew,

On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> appended to the "under-the-cut" portion of the patch.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

Thanks,

Brian


