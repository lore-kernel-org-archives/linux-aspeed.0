Return-Path: <linux-aspeed+bounces-2336-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DDDCAC5AE
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 19:13:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cX62q2zlwz30FR;
	Thu, 25 Sep 2025 05:13:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758741235;
	cv=none; b=Kais3p76HNMgjdjOe1f5oiTlITlkRjAao2aQ2VLM2D0HsFEWuMBNuUnFMmVOS5F+h2tHKCYSY+6EtoWszgeK2LgcE4KNbQWoGv1C3LGm3l8hi3dQmS/5adfjKMKjSfDxMRma5kwHQwis4xZZYeGywWN0ArJ93CmFqNJX8h79pJko6jltw3cG7FAbsbh+oDS417aA2T6P9MDLrRfL0T7zBFpZUneWv6CFk3XCVL3fSuwuu8t3feDKz7wtUFVBBIJY+PBrgViSSR0h9bCCrDPcxCJweYk4M5dsNXodc0KLLuayS11bEwyFQBS60zP9TebNDvHEvRtM2NYWQ8Hro645GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758741235; c=relaxed/relaxed;
	bh=obJxnZekB4WIG8RL7kXppSHgA/amLMeM0pzMUd0i/CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN9HZjxmHTX2GQm6jLrNAfHK6DeiLYC/ZbcHRa66U0pCiP8TsXyQypZe6Y2J4bukRGeUIEySAdHXaO6LpsDVwDX2IBuCQHJOfNuDRv7OoDiBsmEPs4N0/Lgx55YB7x2I3qTnV+MlLaw1W9muyaetfyMXH981gtViuo6o8TDx1yWE20aDPd+oWNL+fOQpsaS8CEDdB96uMXQ2gdJFK089EimWnN23skM3CSCT8lSaLAv7qZ6tklsATVZZiFYcGPw15AsjI89sjwUkPe5f2S0RtO+hHHOlzGmq7DhhYpuRpXmksZIk6fWXODxH5qMzxXWEO0cRzkofMX3jC6j5aKBkfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nMWvT3dn; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nMWvT3dn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cX62p41jdz30BW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Sep 2025 05:13:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2065460139;
	Wed, 24 Sep 2025 19:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94B0C4CEE7;
	Wed, 24 Sep 2025 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758741231;
	bh=obJxnZekB4WIG8RL7kXppSHgA/amLMeM0pzMUd0i/CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMWvT3dnPw4+xviu3m6H3ehDXSQusdziP04daUv+/Qsh3E4fEWSwp+zE8MT1rqiBP
	 ifwatbwbth3QnrQpSSobAc/K3yFQs32TDc4KhD5+p65ZXpa/i5Gr0G7P2vmV7W1pGh
	 YpTdMrsXrgpojrwJC0em4VViA9i5AyVyGJ90/3CzzOsDV0XWnq/GUHGLtD7/AxOdg7
	 rUL9dAVIsZLKHVptXAHKiZe/xmqH+BNvKuhgKmHfEnsqi3Qr+jhBhECiGONdDJm7sm
	 Eqag8hpae1WTMHOFO7oXdigp0TLGIOfYh8APsBWjFrz2+5nPOqGFyd53od+G4FGpUi
	 Prkl+iAW2+BZw==
Date: Wed, 24 Sep 2025 20:13:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Amithash Prasasd <amithash@meta.com>,
	Kevin Tung <Kevin.Tung@quantatw.com>,
	Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
Message-ID: <20250924-flagman-thus-08b0cb14946e@spud>
References: <20250924-yv5_add_dts-v2-0-39a4a8e3c9e6@gmail.com>
 <20250924-yv5_add_dts-v2-1-39a4a8e3c9e6@gmail.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="98eyz47R0E2z5CLq"
Content-Disposition: inline
In-Reply-To: <20250924-yv5_add_dts-v2-1-39a4a8e3c9e6@gmail.com>


--98eyz47R0E2z5CLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--98eyz47R0E2z5CLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNRC6gAKCRB4tDGHoIJi
0qx2AP0cDNVhrKNfjJaL3YkhGqfWYI4zoBzMpZriprMQBVvMFwD/c/iVVQFN2NIl
eI23SXm/4HvbUEm9VtZBvfSuqmBKEA0=
=U+q/
-----END PGP SIGNATURE-----

--98eyz47R0E2z5CLq--

