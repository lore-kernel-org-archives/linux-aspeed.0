Return-Path: <linux-aspeed+bounces-2129-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729FCCA100B
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 07:13:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGv360y7cz2yr4;
	Wed,  3 Sep 2025 17:13:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756883602;
	cv=none; b=lws5Rlhct+Deeio8FbJFyJbSvBxak8fpz/cVXuyFiqa9b1bJi2QvaTACKdHxTZLYnVYt2DlN/0/6WJd7/m87Cu9W//ALh/oBEyqlx356KCPum+TMXnaZtonlarNDyf9aRe2HYkIyu1O8BCGcSBJirESKJ6mela61N+Ot4END2O8sJj45fcovx/KVdyMbR8AQ1sa3Uzifo/4kGMMv95VvbTdEiA5s+YbIQt0ZFPFJacS6ESnj7iEYknkGzhDQGyvXUVIKxv/MfkNnPwBw/1iM1o8ObGqkj42uCNfp4VqiEbbM/E0gpx/B340a7Iw/bC7z/BfPgWaGFKH0id4Lj8+aiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756883602; c=relaxed/relaxed;
	bh=+SKJ2DOUnv0ju3m2fzI2NEnnUJ6bjzNIYaMHRG/U5d0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EcXPrK7FFtRNN4jRryAdmYum0Ynm9KCvJq5uWLyav7uKpxOAwkzwWufeBuM2twT93IXb6SxWoxb0LYTKBsP0Rdz8quepfodzYl+wOOGJ6dxaJsRknZjDKOtgEcYmGjD6oxGgD6mrv4CtJtt7YExVch0CanEdRqwoyREeSbRgaN4mD4vN9CoDVcubjw7fcb/1vBhPzkn4kaTj6SavLJHQIY3UVcRAgWqBA75SL9GzDlxOjVOimm/ot+WEQvMKUFg7uN4ZTWBtzuDnrkbXBcCD+C70yEdf4g2W4VeczZ1wfzTpn8ctCAUNyOUQK+33dwudzSuruSwNogqNl7EnlVK2Yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bXhMGpGc; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bXhMGpGc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGv352ZtJz2xgp
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 17:13:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756883600;
	bh=+SKJ2DOUnv0ju3m2fzI2NEnnUJ6bjzNIYaMHRG/U5d0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bXhMGpGcvrD3ixFoy8jvslo3iAJXogAk94gfIIvFFVj1de2p9FgC/vf5/POKe6Syj
	 nxxTdvMzr4VnovLF2eSUuNrXUUr5c1m36Tpy7b0ioL3PuRqTq4UEMY04n7seQX6fYq
	 eIzMmkXixGU9NhG/jShBOyf726SUtmW3ojaX2hjyzruvVAV2VVj6ne7mZ08Rum+Tny
	 3hD+U1cbT8nVea/WZLXNEnco2SkNMzqtwbpz07c1mu69zWt8WhR94sMO5IxG8scl5m
	 PNQK2r9wcKupbD847qT0eV1lqYHMyXp8EpL1YaOVvNtTPxfUzQiGPw+hBLzekJhx+n
	 wp8lEpQ1rGSmw==
Received: from [10.209.99.88] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BFE386445D;
	Wed,  3 Sep 2025 15:13:15 +0800 (AWST)
Message-ID: <613456d8ec80c29c6332c8a047bfe2a108dd2e65.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: gpu: Convert aspeed,ast2400-gfx to DT
 schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones
 <lee@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 16:43:14 +0930
In-Reply-To: <20250829230442.1495926-1-robh@kernel.org>
References: <20250829230442.1495926-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Fri, 2025-08-29 at 18:04 -0500, Rob Herring (Arm) wrote:
> Convert the ASpeed GFX Display Controller binding to DT schema format.
> There was a duplicate, incomplete binding in mfd which can be dropped.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks Rob.

