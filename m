Return-Path: <linux-aspeed+bounces-12-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2286D2CDFF
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Oct 2024 16:55:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XXywC3N2Bz2yWK;
	Wed, 23 Oct 2024 03:55:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729616107;
	cv=none; b=EQ7LYJr9Wp9knoAOgxmpKiGuQTTpN2Cih/CLJbIhA5AzA4oQIbPl/rvfl5NZhd/sYtLAzwkRrpJ38E6N8O87V+dswynLKwZwTvb4oVYusGuSDBJ383X3ezYA3xre+q6qVZkVC0qzLIUUMRnlHRyNIdtB4gviTeJfs3sRzWGJFiTuC38Gpa25GDdoSrVMF1lV9iIv2Vdd6zQxbYE7tEZdPDnOfbvtB8wFpLealTOd545pCT9eyS4oVxAaTHqS/Lg5wuUYFgoAD4Q4MSePQED/nkKwr3zpcvlMJSp9pE01sub4tWUzA6a0e7wV5d3g8Jwmd/51POc1W8t+9wXsjaZG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729616107; c=relaxed/relaxed;
	bh=dFIIm5rhxs9qT/MajtS4EYkcanyHeA4sGE0hYbhvTFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjWCgA332j45qhuxATZBXkjmSrEFqYepmk6TlQYDrvu5FbhuP9ahhQnHUmycQzM4CFia3VVJQVKpwndvM5EyQw4ufDD8gh93iV1djlIJpCHNvuUd1bOD4WflhtQtyQLAreGH5hK/24stpnYvkFzzeDfF4yi9IL0upNJ4DifKg6rLaWJi3mzQYr3PxBT4btDnBES0lNo+hBy1EfUUqZX9E+n8zXHzUdCCy93oF8Ag2iCVcRTGLLLMFsdcA3UIWbPljL9/TUi/3MRs79G5SIp+0UsYgZv+JjVJcyOa8BNaqZBeCYEPfb70Mx8Y/hq5drYJxEV0TXNBo+XJkYgH9cPfnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EJny844q; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EJny844q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XXywB471Zz2yV6
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Oct 2024 03:55:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3E0F45C5BAB;
	Tue, 22 Oct 2024 16:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72B2C4CEC3;
	Tue, 22 Oct 2024 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729616104;
	bh=dFIIm5rhxs9qT/MajtS4EYkcanyHeA4sGE0hYbhvTFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJny844qGoatCql5qUU/Q4fh8DIy6u3lc7JLAMq5mILuxu7Qg4uY1+ZFPCeHdARm5
	 1jify6tlyKKhXrW1Fy7cpaX3pbshaDsAsHui7wnQMneSf2VvkNq+Nvv4/cWDIWW383
	 bAeLYW8zFI+RNYM8AoBn+ZB/yVXHH6WjJCUw2gQ4PFCmj/jOkMmQ84133NxzSTA7l+
	 QJfelq4HrbwvM+TQqngohC8q5DESZysL8jAPvDEZi9hoAqvsC8XG8K7RaQF2pi9IxM
	 nb8ZL48xzl3BibX88siWOQMGJweVkFS6ZA4L1MWRglx7R/5LkyZ/kbQ64myclut72a
	 1hEdOsDtKdV5Q==
Date: Tue, 22 Oct 2024 17:54:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <20241022-prayer-unmanaged-86ea24caf242@spud>
References: <20241022021724.2322506-1-jasonhell19@gmail.com>
 <20241022-clean-rebate-e986d6a82a05@spud>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fGRR7GdKJMsqfzS2"
Content-Disposition: inline
In-Reply-To: <20241022-clean-rebate-e986d6a82a05@spud>


--fGRR7GdKJMsqfzS2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 05:51:45PM +0100, Conor Dooley wrote:
> On Tue, Oct 22, 2024 at 10:17:24AM +0800, Jason-Hsu wrote:
> > Add Linux device tree related to Meta(Facebook) Ventura specific device=
s connected to BMC(AST2600) SoC.
> > Add subject prefix for the patch.
> >=20
> > Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
>=20
> The indentation in here is very inconsistent. Please fix that.

Also, I don't know what the coding style in aspeed in particular is, but
the node ordering seems very random here. Could you sort nodes in the
dts alphanumerically as the dts coding style suggests?


--fGRR7GdKJMsqfzS2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfY4wAKCRB4tDGHoIJi
0g9lAP43/yhfmMpPGE/UTpJbFPS2SOc0ZEN/nLtKSvc25ObaswD+LyRMqnsq87TE
r6zdEguM3482DqDtUmYg4SQEYytUVgE=
=GZrq
-----END PGP SIGNATURE-----

--fGRR7GdKJMsqfzS2--

