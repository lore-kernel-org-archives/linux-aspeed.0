Return-Path: <linux-aspeed+bounces-4555-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198B1C53209
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f6H18j1z2ySN;
	Mon, 27 Jul 2026 10:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785097949;
	cv=none; b=h472Tqynt50rSO/wv7B96RzGI3Ekgz8+0zfNVd4iqFOjXqmxPMeXJKM8MPr4XCE73PXjH6pNGyqJ6CNCUxpBtfaTddBAXJALN2eUp5ifd4sBjk5j55p0+XpqmgUR7wVxTxbdDHYOsrtGUSegmw06D53A56QNsMzB+vQFXi9e9O0nn3Zy39zDys6a1dNLGb/5wrMaY/GSX8zviUYeapSfofs/is8MiANrz9i3OwesrowOiIaiGNkE6AMrmJGo6dMgAIktSw43PaMudxIdYgTSlq84CVL8kv81gDxJ/dZe81hK7pBfy/3+pFTIgS28rKJTMDuB9v5XxTT9e2QiRiE4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785097949; c=relaxed/relaxed;
	bh=nkBZFniCUCzkEJIn51pXlmXmi8cVBb/p5U1a6qJ9Ixg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuoyShJU/ouDfDP6VJzxspmknXM6TzXK97loXnf6C1+r0GUE4FOoh6UxNLKmGnJlFQNtWXCRDbMi4eXoiM7ZobSSzzSQxJNd/PZAmhlPw+u8+qDOJdSYaHylzvgdlLM5MAtYx3QGtnzov9CoMLLJNGQ728rvp1VuPKCQ2kvinCdXVyejF9Z9i2O7rsPdheFSwyP33wnydclAXLzJmv+lXjqkE1onnocmg1lQzn1ynxPn/ZqEyGsdW4ctaFEUwjqOm+btZb/hbRWwe46YXBz8PRZs+DA+tDep3IyTq+zdyM0dKIObCUe9nG+TfwIke4/qfVXMaMckzZzzZnfTyImkFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4PHVQaN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4PHVQaN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7YLg3m4Jz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 06:32:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9ADC243E23
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 20:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ABE1F0155A
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785097940;
	bh=nkBZFniCUCzkEJIn51pXlmXmi8cVBb/p5U1a6qJ9Ixg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W4PHVQaN9xLoqX8eDXdj+/bdltzbpdrXuJcD/IwTHED/OAS43NtSi09Vq3d6U04b+
	 OZrfY1BdRBIr3/BvT4jphHKxshW4iPLq0SEQ9WJZ6UCiJXker7nVXzDJTQTJeSQmCJ
	 nqQTHDVkWE6CIw3XfTavcgeKi0qWFBHLD4jbLvVP/w0wy9EuQuHMdSUYi0WkY8Th+6
	 o3h8KWUIz3JqQ5OnPdjn8CRQ129kqIKO0RvU9aDDIqv2knEzTV6ddZotNnccrjNDf3
	 gD5p2j+s8qJDRnjJCabcz24JHju2UhLKMDmQz+l+lUVP9hxrlhIX6gKr3NzT1t2xHy
	 xsYC8WtlBRvmg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c83acb86eso17830721fa.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 13:32:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp+9xvBiX0ge9Ovp86n2QVOdg8kAuXwE7m93tDa3smAmen+xo8MHvSKpm9PzD2uMAFYura3k6/Eatcxwo4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbZovmFe/GZvTP4TJj8TvOwbHxGgV7+bcYB2I7Sj3+47Q/ZHq5
	ACmM4bX4SLwZF2XYIHydj7LvDJQR90Ql+g6kgRIkYG3LaafTi29UtLOUyGG19yYr1ji+tkDg62B
	bWcO1x2wDWCLzCFE28HVObi5Q7a+qcvo=
X-Received: by 2002:a2e:b8d5:0:b0:39c:99e9:da37 with SMTP id
 38308e7fff4ca-39f28779970mr10082271fa.1.1785097939063; Sun, 26 Jul 2026
 13:32:19 -0700 (PDT)
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
References: <20260727-drm-simple-kms-removal-v3-0-cd5dc89858c6@oss.qualcomm.com>
In-Reply-To: <20260727-drm-simple-kms-removal-v3-0-cd5dc89858c6@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 26 Jul 2026 22:32:06 +0200
X-Gmail-Original-Message-ID: <CAD++jL=x2Ya_MXrO7FGF6WDzr4dv83K8-TS2AWkA2O0Dko8G4g@mail.gmail.com>
X-Gm-Features: AUfX_mwB4HUeh3S2YxcI83VgRSuUorQHaI7-JMSYPXy-LrwQZEzjVUoz5QHNF0A
Message-ID: <CAD++jL=x2Ya_MXrO7FGF6WDzr4dv83K8-TS2AWkA2O0Dko8G4g@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] drm: replace simple display pipe users with atomic helpers
To: Ze Huang <ze.huang@oss.qualcomm.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>, 
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ze,

On Sun, Jul 26, 2026 at 9:45=E2=80=AFPM Ze Huang <ze.huang@oss.qualcomm.com=
> wrote:

> struct drm_simple_display_pipe was meant to simplify simple DRM
> drivers, but instead adds an extra wrapper around normal DRM atomic
> helper setup. As noted in Documentation/gpu/todo.rst, remaining users
> should be converted to regular atomic helpers and stop depending on the
> simple-KMS interfaces.

Are these patches independent of other stuff so they can be tested on
top of v7.2-rc1 or do they need other stuff from drm-misc-next?

Yours,
Linus Walleij

