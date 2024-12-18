Return-Path: <linux-aspeed+bounces-279-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA40CE7718A
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 15:09:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCxtC3Cy6z30VV;
	Thu, 19 Dec 2024 02:09:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734534579;
	cv=none; b=a0se/swEL8KUlxSNfU1NxF2S84MYgU4gq4gu5O56HqcoPVgQtCnOqiBHN8BCj2z17FJ7pzXprfFtGPZQ7dvH5L/IxcEnw/ty/Gdf8CNwHqkLVuRvcem5aHowvk6+Prb+nngrWPnBF4IpxCsRIktJ6xo6f++HO7UST9HapbusX44eZy3BG36aYe7Bb6e9x4KONw5FhmxssjL2SfdnUTuoNwHJJjurK779p9ARldF99Uwj8YsTRPteboSy6ehKiYL0hrMGeqH/h91SngjSu81FHMTDP6Xo2xDA+jZW9d/RQsw5Moic7jKBNQyMoTLkVqXnY50RGOupQEPnUbfxdiQGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734534579; c=relaxed/relaxed;
	bh=6mDeikeFSe+F1f6WRvocmJwWKAt2yrKKW2tQ+SDhd5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECKwpoFtUxaAqm1oHsHN+/jRD1ZmUH+hZmD90dZrXkBIXDF+0Gv8xXrL17siwtqH3tihuxrcwyIp1yALTZ7+o6sd2pi4TYBQp4TMTvSWkZEOyIzTjX65qGrt1wsIeg5sPvtEibnXOi2GMq1Yii4o+uwGLv8CaG2uZg6HcUQS1Z7GqnYFIeKF/FGF6SKc3Wq/gpUNoKZ89tWr0rTIKpLumzgFbuKxDn4Q8IkTTuFTwpxVIrndB075YG6R9KdmsRuyw4DKXsvs/eHcUvZI/f49uUl3ZEfrjKgX4jxlw+ang1nF6ZHH9rd2dlhJL0d8JopG0O+q8cYhkhig1xpdKu61ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=baFT1s/2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=baFT1s/2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCxt955hXz30Tc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Dec 2024 02:09:36 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2165448243fso65149735ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734534572; x=1735139372; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mDeikeFSe+F1f6WRvocmJwWKAt2yrKKW2tQ+SDhd5c=;
        b=baFT1s/2NPEaCkH4JCKkH8DOwLKgYarcHaM8AYPq48H/ebb/MjBuzX+8dkvslCd0F4
         D5rHkVhQmAWM6VHYIjv4Oa9Sp8/bk0g38tMaSIPPRckN4FwDWhvBrVvkW//j+ywN0vtt
         titMeLF2KbrLFDQKSzR1hydd/kpCHUfuXNrMzmxCu4W38wwSyKLeZIokzJ2B6jRBYr38
         rnkHlY8BojIS5Dj1/toXIYDU3pejJaA58MSE4GUvdX3o9Z62NzJhjm6sQX0THVelD08D
         ZVYJT7sRv4m7YwuUMO//5MkFGgMRyV8NLYgTjTMheWQPIMuviFeMkN0Jn+FB6qgyerjT
         OEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534572; x=1735139372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mDeikeFSe+F1f6WRvocmJwWKAt2yrKKW2tQ+SDhd5c=;
        b=lm/L9qC/zCTcFfedsJwnCF/lwWz3CToqJTsxi3c1YhBai18x67ATHLmESDo4ivmAae
         FsEaWAOHi+DEUnRHBSQY3EWiXI0zF4qiVfoU5qvwQv9e1LfM2tLbZvuio6xhy6AaB5h0
         C9NqqflgV2/OcX5eRoG0KIF1OG4HCN6GVgHmeIHSN9E5v2oWyO0k/qz77aV/Y8YySHRq
         eTSBJ0+orW0x8yMPvF00wDmRdQqGos/i4kOQB5QAAJcoL9bCwz0Ci672hXxzC8qxcteq
         l4iEHRXqAoHOSpzkDtpLr/K/eld2A9h8bNMy+Pj+HN6oDaBG1Dnu8/JPvk1/ohGbaQRR
         wVyA==
X-Forwarded-Encrypted: i=1; AJvYcCV8qOytoCvzZHaZDz7KA9jzWeB9Ido7F2bGEdkPzcP7ImK3fS73zfYCIJQcc+yFd+TbFiJi4udgiSGnTho=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbhvnJse1hp3+m6P5myNDd/2Px53ySVDSO1AB+gN9AgsLWBoLF
	4iww+2+TnUgU7asw0xhwQ+q0d8hpNPaTH0qevtu9TraveMqCuSnb
X-Gm-Gg: ASbGncuf284NwTXeIRY99KCGfO965Ql62z1oCOjehKavoD1NjtIfaMkb2IV5ccy4kva
	1erS0erwHTlXp0Jwc4hEKmhZjbBOoJkvhhUxRAETLujIRkLJCgiSmV3aA00k6BriXRQFma/TXdB
	GnxoVjDsSfUSTYRcUxo9Y/8d/MZvir6cPe7Soxsy7A3V7ZvV3Vs0XmUal9O3ux3J+3bmH4oWv0A
	OLiRpECpuM9NKBtW8ege+cSrwSoyZyibzg0K+UjBFUsNIr8PDsvG2p4qiKfV8ZJIMXXmQ==
X-Google-Smtp-Source: AGHT+IEewReQwgk+5Ua6YOOIYy2d2/wQCgEBDZk3bKIj2d8jpP3GFkNNyFGtuZW0MM3ArXC6dPDOAw==
X-Received: by 2002:a17:902:f68e:b0:216:4b5a:998b with SMTP id d9443c01a7336-218d7252a1cmr34156515ad.45.1734534572373;
        Wed, 18 Dec 2024 07:09:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e728a8sm75452185ad.280.2024.12.18.07.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:09:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 18 Dec 2024 07:09:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	eajames@linux.ibm.com, jdelvare@suse.com, corbet@lwn.net,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	Delphine_CC_Chiu@wiwynn.com, broonie@kernel.org,
	peteryin.openbmc@gmail.com, noahwang.wang@outlook.com,
	naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com,
	patrick.rudolph@9elements.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 1/4] hwmon: (pmbus/core) Add PMBUS_REVISION in debugfs
Message-ID: <89ff7229-2e86-4d36-9349-50af109b0085@roeck-us.net>
References: <20241217173537.192331-1-ninad@linux.ibm.com>
 <20241217173537.192331-2-ninad@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217173537.192331-2-ninad@linux.ibm.com>

On Tue, Dec 17, 2024 at 11:35:32AM -0600, Ninad Palsule wrote:
> Add debugfs file for the PMBUS_REVISION command. This command provides
> information about PMBus protocol revision number.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

I already applied this patch, so there is no need to re-send it.
If it turns out to have a bug, please send an update on top of it.

Thanks,
Guenter

