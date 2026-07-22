Return-Path: <linux-aspeed+bounces-4523-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC9EC4451C
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 07:16:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4ltC73NVz2ydn;
	Wed, 22 Jul 2026 17:16:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784704595;
	cv=none; b=LHei153fmhmZU9BTmid+ogK81DgD/Ej3bALR5DUK3lhm/CkOw2GMfWvZSsHk3bS45+rU9IvCSClSYJlVYlaUwGd+SD09eJoQdFEaNM8Xzl094NEAircUh+Lo8VPBJ8e8gVA2VcU9Km6kCraGOlf3oK4XnzJJgbs4bX4c7d5/8e+uoC+fldywMj6i9+YAZevOLLtHVQ+9mqzE7saFWjjJxzW7GFPnHb3YoHAgksrIUh6U04WL/GaDcmUOi5YlOZsi4OvWFOzTTZTGQ0VdFhl4IjtTOnWoN2t15w44sGEgqilsm4Ny3pye1Klb5JLqoPOz1XVUIcad9WlEdgQco7Zgug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784704595; c=relaxed/relaxed;
	bh=K9/chxFPPa22IO8qa27xxpbmwA43QsAQuqs/BaliX5M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKRgFHpsBzr4WtCyC8I67A4xi7KE4K/7rIoUd3CJS0aFScpPwfjIKBSb00SX78xvhknLNV1robYp8VNkuNRW8IukdabbBwLr/+V451c0U67aNwKcsZvFrhuCURgXncgzLcqE8e/aD+KF/vk8yFaf+jw+OFHDeDJiCGaoHaAeKPfCFZqPUa8YNbfwtG8MwDVjzaNfZ2O73qQM0OXXDfJGe9n8ZuwthJ+o7iEKzOTAOgN5Mq900M/0JOtSb0MtGRi1n3YY22r6+JfSDPeJ9Z4Fon+mUMWKWcB8cXs0wkddEmR5s5DJDhbE+q/dri3C5Dnzx380FsWYNtxafXXo67trqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=IjLWOwwF; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=IjLWOwwF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4ltC1szpz2yd7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 17:16:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784704594;
	bh=K9/chxFPPa22IO8qa27xxpbmwA43QsAQuqs/BaliX5M=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=IjLWOwwF+Vkg/0/TOKB9y0d4L/1Iimn/gdWdnmdiBRcqFsYOQd7ZSO6YumYjqsIEk
	 SUQyAUcHyTsJ3QMKaVP51PuvnDeST0/SLcVuMDBdq90V5+xSPv03yBwW/+Jl7+Ti9K
	 pGCmPPKpfJ8MFlYthmoutoBPPmSyM1eaxVkfdb3YC/6ciK2vb+ydDf7mh3nTk6KyCv
	 3pUIMAo39htGVcsv1BlbVy266/QaimoBFpgmoHmffolwDc0I+dy5oRqNfGUqADgGKw
	 CI0s39eiWAhPuvoVCZxOtNo3FirpFBedm0e04+EtRsZKqDw0rPv7Wf5ML0KqqbGg3J
	 AmBAvWONOVvhw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7810065B37;
	Wed, 22 Jul 2026 15:16:32 +0800 (AWST)
Message-ID: <e3e3d647b9194b7ea4b88241a37df184bbdb307c.camel@codeconstruct.com.au>
Subject: Re: [PATCH] EDAC: Remove redundant dev_err()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Pan Chuang <panchuang@vivo.com>, Talel Shenhar <talel@amazon.com>, 
 Borislav Petkov
	 <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Stefan Schaeckeler
	 <sschaeck@cisco.com>, Joel Stanley <joel@jms.id.au>, Andre Przywara
	 <andre.przywara@arm.com>, Robert Richter <rric@kernel.org>, Khuong Dinh
	 <khuong@os.amperecomputing.com>, "open list:EDAC-CORE"
	 <linux-edac@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/ASPEED MACHINE SUPPORT"
	 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/ASPEED MACHINE
 SUPPORT" <linux-aspeed@lists.ozlabs.org>
Date: Wed, 22 Jul 2026 16:46:32 +0930
In-Reply-To: <20260713131510.332386-1-panchuang@vivo.com>
References: <20260713131510.332386-1-panchuang@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Mon, 2026-07-13 at 21:15 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"),
> devm_request_irq() and devm_request_threaded_irq() automatically log
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>=20
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
> =C2=A0drivers/edac/al_mc_edac.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 =
++----------
> =C2=A0drivers/edac/aspeed_edac.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 =
+---

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au> # aspeed

