Return-Path: <linux-aspeed+bounces-1231-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C00CC3DA6D
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 May 2025 15:48:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1zVD47x2z30DX;
	Wed, 21 May 2025 01:48:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747756100;
	cv=none; b=H9ClMCBWBA9+YU88aR8JwfpH1E3T4WIi0jUe0rTNHEPVWXYblsR1lTkoC26vW7FOotd+DWTUuIE2E6SjRLWYE1G3LOC7rdP3N5Rmp0Jw494QTs1v+oktCyyzt+OlqqgQwa2hQChJkIpePD10MbeDJFaJhz0HKylXXW8jddDVBlGSsfu1HJE1QQHRKz+aewWWsf+ujoJF1zzraI6n6kaFrkz7wcvc9r8V92mxbeHlZD6WgcDNlfv0if6vORTsOa0NhBwFxfB9XPhzoNOu3C+mTH40RaD7yysARvoC0KYQUfI2xtD9l6WEm6oIwHIVG+eLeYpN/VpLbzcAhq0EaStGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747756100; c=relaxed/relaxed;
	bh=Na7JhdnilcYOMSmY3FiOD82OSlegu9QIZHVGHZNYf+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyK+KGEPDuqNShJ0ZZhiYkXZNreMHBLFJhQUP8xe5Pbf564kEjrn9XH+npL1ieNy06xBzY7rMHpMSCKzBO/PePEb+ERA1RBS2vX0eAw2OEyLuQMLw7+XsP+VAXeHZgZaPtQWmh6QZfGPXRqqhTWo5UGggICyX270IRWFKNJ0EoPAyDtAfAng5zHdRm/itq8CU7blwOP2hPbLjL51Ukka4qS8deIxRzxuOhN8711Wy7lPp5Y9/ahYuigezvCg+nmhS0RzXp08GZsZ3m8khAMB7X7heuEp9DL66sxKBPcyRrpSAonzhhnWY8Wv8oXsPbimvJznFjVbbGydJZaBAMn8kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BzJbViYv; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BzJbViYv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1zVC6YlFz3055
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 May 2025 01:48:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 591B9A4EAC8;
	Tue, 20 May 2025 15:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F137C4CEE9;
	Tue, 20 May 2025 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756097;
	bh=Na7JhdnilcYOMSmY3FiOD82OSlegu9QIZHVGHZNYf+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzJbViYvKnuAovyYZe09dS8NHjgji+yJvJjuR77hWD1aTLvfIMRMqREH51Mgyw/N0
	 uHKKvfu7s81RbqRBRgxYia/WZO/dyro9Q/kkhBvveaZsuZXSKudaGql50akbvQQ0f0
	 jjtgC2yV/mQZSkdR/vToznC/FldLOt2sG6EXLsBQGhV4N6QNCbCeVD4HgWIMpEvB/Q
	 fPrC+/JqRvSVoOLdH7c5EDdDH2N02XOU5K4xpgz+adNfY2HuGXGa9v5bMLIW9DFyA/
	 ZzM4GiiVkqRWR4QTxFyk9/W+a70WuyagPXo3wYdnr+dChOLTJhGrn3CjQVUy2tFdso
	 IoF2Nc9Y1bONg==
Date: Tue, 20 May 2025 16:48:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [net 2/4] dt-bindings: clock: ast2600: Add reset definitions for
 MAC1 and MAC2
Message-ID: <20250520-exile-obvious-b72b7db702d0@spud>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <20250520092848.531070-3-jacky_chou@aspeedtech.com>
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
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UvQk65mnV/tHD2qu"
Content-Disposition: inline
In-Reply-To: <20250520092848.531070-3-jacky_chou@aspeedtech.com>


--UvQk65mnV/tHD2qu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 20, 2025 at 05:28:46PM +0800, Jacky Chou wrote:
> Add ASPEED_RESET_MAC1 and ASPEED_RESET_MAC2 reset definitions to
> the ast2600-clock binding header. These are required for proper
> reset control of the MAC1 and MAC2 ethernet controllers on the
> AST2600 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--UvQk65mnV/tHD2qu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCykOwAKCRB4tDGHoIJi
0giFAP9mpUDwyGsaZ4s+JSGA8E4mfSJLTl4kzfMX6Vy3keT5qgD/eKnvov8kgNkW
zNvHBzlyYwGeF2M/jKKSqLaqEjzsCwU=
=TAV4
-----END PGP SIGNATURE-----

--UvQk65mnV/tHD2qu--

