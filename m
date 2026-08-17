Return-Path: <linux-aspeed+bounces-4741-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3377C5CFC1
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Aug 2026 07:16:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNkdr1B5xz2y1Y;
	Mon, 17 Aug 2026 17:16:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786950976;
	cv=none; b=n5RQjUezAgakOOUMxSTNBq1a91dhqiiCMvHPcLNsLNhhTkYzZnxvssRsa4JB3PsfzNPKEFAbKPGiJr7osMGkhXNooyICvawp2fSDYU47qRFZ2tKVCKgqhQCwiDMyDLWUnO0sSjIwbCDTVDeMVvOGmJEmQR/3gxs3V2k6cwO3X1LvNymAufGjskKfyfCOCSzN9yGrjZsFSObRHxG0gImxXYR3K84dXQfKp0Dc/dzMJHoGKLjKsjd9CuekwvwJIj7w15jhjOGWw0xGkgqZOv76gKyBX6llWALb0ksR/1D93m9KY63T2IJrHijX4j1py/NA+Cs+RDuciy2IOjReGqso/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786950976; c=relaxed/relaxed;
	bh=kMKlIBl3NAuuM6jvx30dD/Hizd+fyHJnLS0PwEyzfBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrZzH9vLxk15M6m/in10hLHc1XcKyG5eLaqXGtJ/F3s7QxUoPJLZeZBloY1K+hg8ckFdvWaFc3qwEjQmcSiGPYcj3nCGBUNQEIAqtqLA9XmLm+/evDL2+26wqGWypExrH7iKx+Bquu7l0LS/PJqX7zO/qz2oocYttZyWS46LD0nrwShBHUp62cqRD1iCQGVZri7d5ZqpJNVqLEUooqGrzAIhbslv4j/G4nkICLRiNyqNIP3WAW9KnnCEqPTlTglByMaDhKmGIW2PRv4ROi8wLHUqvDwshJ4+UT9YQNRAzlH85RhXqtITv2GzfwwQxccazI0SAwQkYiI31dztNLnE0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ls9iI2r+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ls9iI2r+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNkdp6rRRz2xy6
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Aug 2026 17:16:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A352601E9;
	Mon, 17 Aug 2026 07:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA681F000E9;
	Mon, 17 Aug 2026 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786950972;
	bh=kMKlIBl3NAuuM6jvx30dD/Hizd+fyHJnLS0PwEyzfBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ls9iI2r+IlBlLw9a/a2pq380+4Uj4p8CPg37Pz3IGZq7RfdNs64ygbmNAoFmBPYZQ
	 XCupHoFDg7lHseSajml1GcWDUKKp53Ug/1m/d4VR2KXi0EnaQu6tJnA8z1OMyC8jua
	 ncy8dUte2S9BS/+u3r99QD8JIW6Ne649nZpSqlJakA38BclnVUN55lVUrfkFcAUfkm
	 gtEELzBCzyBaFe4YKFlAgVwc7AcBN/D/7zZ/xWaMgZYoq4Xoub9qIYsH2veCwMJ7Do
	 Dfd+C4Rvovr72/qUTDNsH9uraVuRBIa/um8PE01cWRDUPzspnQhOoz2NGfeIllKLnt
	 5hWhphvCtM8Wg==
Date: Mon, 17 Aug 2026 09:16:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Corey Minyard <corey@minyard.net>, 
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, jammy_huang@aspeedtech.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: aspeed-lpc: Document lpcN alias
 for multi-instance SoCs
Message-ID: <20260817-icy-peridot-mouse-ad50f6@quoll>
References: <20260813-upstream_kcs_multiple_lpc-v2-0-775b1db3fe95@aspeedtech.com>
 <20260813-upstream_kcs_multiple_lpc-v2-1-775b1db3fe95@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813-upstream_kcs_multiple_lpc-v2-1-775b1db3fe95@aspeedtech.com>

On Thu, Aug 13, 2026 at 02:42:31PM +0800, Yu-Che Hsieh wrote:
> Some SoCs (e.g. AST2700) expose more than one physical LPC controller
> instance. Downstream devices such as KCS channels need a stable,

We do not care about downstream devices.

> globally-unique index derived from which LPC controller instance they
> belong to, so document the "lpcN" alias convention on the LPC

New aliases are generally not accepted and if your reason is
"downstream", then answer is simple:

NAK

Best regards,
Krzysztof


