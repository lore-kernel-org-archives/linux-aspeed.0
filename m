Return-Path: <linux-aspeed+bounces-2384-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D6BCAC5B0
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Oct 2025 18:46:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cd12y55cbz2yqq;
	Fri,  3 Oct 2025 04:46:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759430762;
	cv=none; b=bGgS+EZRmK17XKseiA+N9rGnT1wKp1jSsZ8hdno90L+Pd0w0Tj3I0+onKsBKslcr+fbNxz9GXoN33GqeKKh98NVOSQ+RN71lASpWhbegid9T2uZlZNivzBQ0VMLtn+jGQKGtHBDu1VOcGXVL4mUD/ICg7Bu8TxybpcWzVYUj/lQTnejltpm3hIp2YuNm3e1SlDNOm6Eko8W8WJ2Pv7ej13lxYrmTo0DZpzlyW7amW+HIizy9UkHHdbhL/e/7eHd6YfgbkLsz1uDp2cvMV6EfrmDEi+gvuJTlLfpFZpSlteAmwZTRzIlcq1GZXRalYxKMcTqowZhZ5j1YUf2jXybqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759430762; c=relaxed/relaxed;
	bh=a3c8V1hXrVnnDWPg12yqNE/isCFFOAhndMURyTvIpzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnZq+CLVYfCbc5puXHLqREy5tYd27MJLpUWt9S62sXARoKXqxhZF5i3XGyc3avAjWc4HLVbUMuZuiHtSp4ZHdPXb5CCVbwFMgn4bDdRNYYRYb3F7okkmIwx2hVdi4lc32/HZ9j7ibJPTetrIaSEDaKdNwqcyDc2ul2km46K/NkVG8tNDtw2Mmn5Gz2tdmUczoxdSxZNpK8qInVaXMtjfgWBZNPh2WC4vR+k8PQLpPhMa4VqWVv49lg8DnkJk4BPckf9q0iHc8jwh87qiPHa90eyiavYIYp070RnbIQXNRl+p2/CLUn6w7p030JIoUDxWQCFa2cF+CN74KcgmfP9CHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iQhyisly; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iQhyisly;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cd12y0ph8z2yfL
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Oct 2025 04:46:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BE79D44CD3;
	Thu,  2 Oct 2025 18:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DF9C4CEF4;
	Thu,  2 Oct 2025 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759430758;
	bh=fTeswSATcB2l4kKFC+T/Jf728hFziZCZ/toefctXIrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQhyisly4HVJjxG8UgkQns4wkNuHmaejeAERzdvdF1DOHjL+v6Bijl7RGahduUQX5
	 JryMYDLDa2za9Rm7NFm6dfYQHXByP2D0h1nFvvE9WTo/ylGOFSsUjXc2gLBZh2Uzsi
	 sOxvOaWgZfi78sMocLj7MC6NnndZTXtnjiv1Xhh0PLMCAswpJhAXjB6ITNlkE7Mphr
	 BJBpw0B+GERHJ99qcq6CblICTnd2PEShT0lrY23J0WX/rClzikI8YutFJ4Pg0m0Wyi
	 foVB+OzHWCWkoKDHaQIMQfQ2y11tjyk9sOrUh2+6ZXJH9fpu8hpnPEQZihVn0ou21l
	 zvYQquUQcBCzA==
Date: Thu, 2 Oct 2025 19:45:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset
 definition
Message-ID: <20251002-accuracy-gloomily-a3e46d5a3f02@spud>
References: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="eQ5hYxmKmELL5wam"
Content-Disposition: inline
In-Reply-To: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>


--eQ5hYxmKmELL5wam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 05:56:51PM +0800, Jammy Huang wrote:
> Add VIDEO reset bit definition for AST2500/AST2600.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  include/dt-bindings/clock/aspeed-clock.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindin=
gs/clock/aspeed-clock.h
> index 06d568382c77..421ca577c1b2 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -53,5 +53,6 @@
>  #define ASPEED_RESET_AHB		8
>  #define ASPEED_RESET_CRT1		9
>  #define ASPEED_RESET_HACE		10
> +#define ASPEED_RESET_VIDEO		21

What's up with the gap here? Are there another 10 resets missing?

--eQ5hYxmKmELL5wam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN7IYQAKCRB4tDGHoIJi
0jpPAPoD3Ml/y5Zj0L/EgesLMAZ+GyKvd9Lokp4c6QrcNGpuVwD+JY5XO5FYrPik
Fl5hcgGgK1Zfdf1qYGlZVllML/j07Q8=
=ne6M
-----END PGP SIGNATURE-----

--eQ5hYxmKmELL5wam--

