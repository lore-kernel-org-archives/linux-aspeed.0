Return-Path: <linux-aspeed+bounces-528-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804EBC02182
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Jan 2025 10:17:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ycjmr1mxPz2xWt;
	Tue, 21 Jan 2025 21:17:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::22e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737454620;
	cv=none; b=LRb2jtwixgTVk1uHx+NtxVaKEcWpJ8P0kSdU8OQNoR/aOl1D6tKfRvzE5Zl+My9sP0q6HFestwA4c6gkF97X7SaelZCgRa1L0ksGooKrJkzJY6lSYQx2CU+TjlaWpOuFozyDzVEgZt7K+oL40PeLOvOjHmF4oX/jWgE2oac8K2mLj2xaeoOs+eC8OUgtGZ5u6DrS0qcUhwhPiBAgKX3VjmbnYGxg3Mw9s4ptF+imL9L2VYWvBohkH9z6+GrSMMzD1lzOp7Rlfr1cS6QQzlw/0r1rzIHmNquRLsMEoqZXJAV9SLxfZPXGFGoZ8VcVlO7Yo0lisJisT8YquyL//Hi4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737454620; c=relaxed/relaxed;
	bh=2sKmlgZFxW5SzQMIIe+zswmZcO3cIm/lz/eCX/l5rXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBSkkoqxjyZl81agc6iXXX9k4wQrbuE2aEEHEi9f7XxUruwNDV1bi2edZQ0Ywj1E4vQkqTAMyLxyHADUwgz8j2G70A4h/DOYVb6G9aY+Yceatd124eRjlpYX8qJhYjJWFdvxEzFsILxIoq4eoVqufEWPipFFKIqgEsKVcKXyybJFMTS/Pf7vv04FHDISNxvkZsHxpvaA4OeEzX6aqDNUqEdyxastChW2Eo5p7v9QRcg3tLnKcJi+m91L/sUmX+h/owl9CqKHnwL355jwT1pfKL78p7PoJ7DtHUnWq32y2nZH2bhs7z4Obo+oZ9gO00URSm/Pv8/Y42gtI+MsQATHAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I3VVf/v8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I3VVf/v8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ycjmp7153z2xVq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Jan 2025 21:16:57 +1100 (AEDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-30227c56b11so54915421fa.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Jan 2025 02:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737454614; x=1738059414; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sKmlgZFxW5SzQMIIe+zswmZcO3cIm/lz/eCX/l5rXA=;
        b=I3VVf/v8uNtXZ9GjwqKNAHSxw2pEFB3UkmlI1pQ21FI38bfMIhW6J9HS46jLOZdYp0
         vPjDSmBU+TUatIdRRBuPuaSq9fMtsW2cJWW6CNwZ/y1MpFEDMtJbg68vR38VUw1JmX+T
         X1YoHjLVhYd6JDm7FCmU8pVm7oNVMz/MMoTvvGMTL/tjipmp/o9Rgd8QLfF7Z9ZakPtr
         PPYW/1n2/WkR95JACtvHocsu3tpWi2IunhsHPVZ6iOBk66pZgxK6njbT8/ucjPuAhmXj
         1U4/vFB+vgCvgYalGurdj9VjbSZRHJAWRyQwgjWX/xTyEgGSRCGwgUUDuDRXeUcTCysR
         BC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737454614; x=1738059414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sKmlgZFxW5SzQMIIe+zswmZcO3cIm/lz/eCX/l5rXA=;
        b=bzoF5fqScATZflLf9W+i6FECw9ztjsZozwpxYNrK0qxY60BKybDx2gJB5V+dfWhext
         /18615+fuuA+t/ddkvRX2Sj0i7HNwajruPlGsqdHpT3cVLQD8+E/og2+Wh4X0VduNLQ4
         I4dGDCGgNOEFVIKPkLGlgx2u24/LsWkFQJvO+1Wla2aGa/LpYSpMU5uWJ5jAxPXrHWxx
         KRyls10Vj4rPyvH3t/OK/0W1XdKc9ZC1xBy4qp68Cju/H5fA8bUZ+FjLjl+yfjeO5hg/
         hD2wz1TbPNCjOWH3NZgO47N/2QG6Aphd0O5V2M8rTgC+evWU7DuPeanVx50vBWLmamm4
         4Oiw==
X-Forwarded-Encrypted: i=1; AJvYcCXRVFt3H7vipJqLTD8vTyMesHwW0ogjHdHtTirkTXQMx09byE/hzq1Zk/B00zvcRGYtZ99Vg24SPSkbgu0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYGyKfIKUTjjHPsHDbHWlo24KJXjujHezXUDOq6+aAAc3wr6Qo
	Inxkv65Wdxm/CvCs49JdHZPQRluRPaDGj8atlUYW2gBzgXo64Bothqqp6JBm0bw=
X-Gm-Gg: ASbGncsFZzL553NSUZ8oIXb6NZ2zPuDYk8Xof/UXfXqx5I8QhO1yxVzHStFL/iGON/3
	7y/ZZbF2ZkVQ35m6drzdwSfPVc/W3DUYKmHTlECM6y+pdjPt0PEewq//GJ+Yvp8lJMy+boiM7Vx
	ej6abjSAHN3IjtWYEmjgm+jZzGjF6Zw70dxq7r4XFIPfRtlvPHt4cuCr9ej5YB6TZT/jfVzbjVf
	yzq0jV4Shv4cifVQY5/1dG8qK81Bdp+O8HtTjAAWNX03bsdh4IK67X6GN78mhoPjDZrze58pulN
	BJYGbX0DC8A1CGqeQOt286VhT612/q9OUj5tagKFIDihzZEd2Q==
X-Google-Smtp-Source: AGHT+IFznj5QTkxejj1h7e2DHbCZsbF1n+9b/WPMSF7tP8oviwsQK24SYuQjBNYHiYuWIa5m3UyWwQ==
X-Received: by 2002:a05:651c:1309:b0:300:3a15:8f0d with SMTP id 38308e7fff4ca-3072cb284e5mr59022731fa.34.1737454613712;
        Tue, 21 Jan 2025 02:16:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a4ed203sm21215321fa.73.2025.01.21.02.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 02:16:52 -0800 (PST)
Date: Tue, 21 Jan 2025 12:16:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: oushixiong1025@163.com
Cc: Joel Stanley <joel@jms.id.au>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] drm/aspeed: Use devm_platform_get_and_ioremap_resource()
Message-ID: <b5rhfo6q6ko4vf2vubkcma4v7dnpxruh7peyqav6tszj4sg6ee@mzjc543jsujn>
References: <20250121075041.201599-1-oushixiong1025@163.com>
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
In-Reply-To: <20250121075041.201599-1-oushixiong1025@163.com>

On Tue, Jan 21, 2025 at 03:50:41PM +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
Missing commit message

> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

This doesn't match your email address, so SoB is missing.

-- 
With best wishes
Dmitry

