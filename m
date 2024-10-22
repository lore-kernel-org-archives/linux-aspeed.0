Return-Path: <linux-aspeed+bounces-10-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E15D2CE01
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Oct 2024 16:51:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XXyrT5Y6mz2yQL;
	Wed, 23 Oct 2024 03:51:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729615913;
	cv=none; b=SluwhAL/Gnc1A25jdTu4KDtWls1rky7fum/CXKW/GVpeGyAJGE+yE5GbnNCepdr7GyN+Do0bQh3L7gHYXRGAnf/1TaSpPXx5ghaI5BroReWY5m6SjJgaxCrJdAQURuVD69eRRN90k8zcLYykTa8ivLhKA5NX6+r5V0/NtLgCcuS3GzrJZJo2hsyvbT1lo4kcwqAapZY0LMbYlBeGLh4ty5SSBdfsQyThO84bNByBs5ZB623udea+rg7AglLsLCLNIyQh2eK01LEa/3BdB0INnYGNyVAeoJ3tKSjwZ+eKsNoH30z5YD9MghRRg7HZxbDewmp7rwtWHb76M+w4H+GtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729615913; c=relaxed/relaxed;
	bh=G+lVpa+HnPdLU2XGwcAvTF5ynzGYq9w6uSs7iS+poiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFQZzA0yvuFGd9h1qR4iku2qgs0Y+RONKefYfBil7CGO7mm04/9R0FJQkdEKebNNARWD1nsSupwXLgl6BJdH8a0ciWot9+6T0EWup5QFMYih2NCN1mnJnfdnGKixf6geAedjzeEneyS7lFhfTWt3e+V8c2KVy5p5jiZscU38IygQiLja0NyFR+ghMAOAYc8i3B9aLolVZOQwS5l29/FJArV2BWUzkuLMD0TwQUvUE5iZtcJqbF07ZOqP6sUZL5t7y38SGpzXouuC0/TvtqRzicAGlmDKTx7MGZmlskda6B6kFRy4EPXUvrB78eBjaco4QoJ3X8u7lvGSCCnInE2Ohw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rHIC81dB; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rHIC81dB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XXyrS5867z2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Oct 2024 03:51:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CA27F5C59B7;
	Tue, 22 Oct 2024 16:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59311C4CEC3;
	Tue, 22 Oct 2024 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615909;
	bh=G+lVpa+HnPdLU2XGwcAvTF5ynzGYq9w6uSs7iS+poiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHIC81dBP9ugP/4tCZ8LXztynVpyHDmlQDRf1SqH02QlVBi73aXTrcEd1Ya1jfdIm
	 dkTRdc31gQW6eiaTi3qmX6iCf6c7GUpSdSLueYyyq3bwP6uzC0GqmQmYeJljzTQgJQ
	 UntfusMGk/vzWjxLqQN87jgNrOPxXzxCbBuFch5Q1gG8TT8NGVHv96p5Z57PsrVBx+
	 SchaGgBEBrF4tr3UWQW2zxwZXjOEv5v6/RiOmijniM6r1aaUqf5Oug9Qh7I5ZKP0u4
	 4ggcgVFh7Lyb0XXeT5r9YF2Dqjd5nV3B+uHyQpjFEt3VX9hPvUxAMDnBkQ/NCE9CcV
	 ov2TFuVQDVevw==
Date: Tue, 22 Oct 2024 17:51:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <20241022-clean-rebate-e986d6a82a05@spud>
References: <20241022021724.2322506-1-jasonhell19@gmail.com>
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
	protocol="application/pgp-signature"; boundary="o2l81eJhq7XAs0r5"
Content-Disposition: inline
In-Reply-To: <20241022021724.2322506-1-jasonhell19@gmail.com>


--o2l81eJhq7XAs0r5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:17:24AM +0800, Jason-Hsu wrote:
> Add Linux device tree related to Meta(Facebook) Ventura specific devices =
connected to BMC(AST2600) SoC.
> Add subject prefix for the patch.
>=20
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

The indentation in here is very inconsistent. Please fix that.

--o2l81eJhq7XAs0r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfYIQAKCRB4tDGHoIJi
0iUgAQDUmHPH4stEsqpdhMw9XHmJe8bKOJjTaat6ZehhyI3fNgD+J4CDQVPiHtlr
y+45Gh+Rxio1Oy/A586b7BrY+pdXeAQ=
=sZs2
-----END PGP SIGNATURE-----

--o2l81eJhq7XAs0r5--

