Return-Path: <linux-aspeed+bounces-5185-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AABCC6B08
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3pzb57J4z30VV;
	Tue, 13 Oct 2026 20:33:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791883995;
	cv=none; b=V+ZIQszi3JSTcaZ5FUmY7VnP72aNPMsIeNnDyOVmOv2V1xgXUeVvVHEaPKA4t3J9wni8nh6xHC+uQPfZJjXdHOq65/KQy9zWsEdyzExky7yoZiZjCma4fLilszR8mXPjoDcAk3ktDUfinJmaS9Ya0KmHEgS/bLEWBopRAPSERahH0dFzaC+n/bXh58+SrlTA5lpjXdr8wLecRlUBqG772tB1pM55r1wsDFzNd/QDrCqa67rvTRejI2YkMrka1ORex6NY1RZ/tPNNBugsvEglw5qpqwPeLrBYDDjbRXbPdou6f8oaX2FdnzJxFV0r0UKPoIs5gC5a57iFEYTS3+R3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791883995; c=relaxed/relaxed;
	bh=eXWwLO4f27zLzjYaywvcUXu0PszcUzOkRGtDDmJg/mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPiHzmEcyYjYchOzCVPrEyGVLBMZmsca9kF7D2b5QbR7j4UXLARAH3MuIkphehg7tAMTmvDvE6RWVLu7UkdDYZJl61MHaiduWaiQhfVlI1i87CQ1JN5J/ahAZUHjAJCNm+W4Vl/z9Z50UwRqzFQOfgA5eXvlOPG2Wx7ls4x8EB9ai2anPnUbghDnMoVpPGLqdKG6Kf9PnyIhkgyk+bCbUzgrws2q0mSbpWHNtV4B/bazccIXFxoWFfTv89m58szPnOxbprsvhy2XmrlLpy1ManwVnTlm2Hx8JdUS1Sfqhb/wBExThWdJBGK0wu/8q/leKcKbE0vjWYs88pDiiFXEGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpGJpECm; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpGJpECm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3pzZ5dZtz2y2h
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 20:33:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C4B7A60A7F;
	Tue, 13 Oct 2026 09:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64D11F000FF;
	Tue, 13 Oct 2026 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883991;
	bh=eXWwLO4f27zLzjYaywvcUXu0PszcUzOkRGtDDmJg/mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BpGJpECmnc5GxGubaFlWpDQl4qaGSZ2UveCm+TNNzJZWXRKayz4Rmf+L2QFacrirh
	 YnR8BFP6LodCdz8smZSQYduJjU2p3dbVcw9LuZFURwfnaUAGYaSWTXrXBCXQmVzviX
	 lIWY45DPbKXmvNrAQvS9BrnJgWNJW7bszssvjnI2eCf1Chsd3g6vMQ0aaJV7np+N9C
	 OQoM2vAXUqL/nhb5fV6ybacrvnn+ds/EL2B4kT08NC4mHHmMCLPosZxU0tngS06mkM
	 J5PIvAcNMD4TnkFlXk2foyPEl0VdDGAWrMQ3qW/Pyh5rdAYalfuZOI8VyMGAe+0jZ1
	 xlvI0HnD5+iWw==
Date: Tue, 13 Oct 2026 11:33:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, maciej.lawniczak@intel.com
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: aspeed: Add Intel AVCRP and
 JNCRP boards
Message-ID: <20261013-sincere-lemur-of-unity-ede6a7@quoll>
References: <cover.1791825961.git.dawid.glazik@linux.intel.com>
 <0b8fbf07323894a48a777ea531713a0285e319d4.1791825961.git.dawid.glazik@linux.intel.com>
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
In-Reply-To: <0b8fbf07323894a48a777ea531713a0285e319d4.1791825961.git.dawid.glazik@linux.intel.com>

On Mon, Oct 12, 2026 at 07:39:05PM +0200, Dawid Glazik wrote:
> Add compatible strings for the Intel AVCRP and JNCRP BMC boards.
> 
> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
> ---
> v2:
>  - Squash the separate AVCRP and JNCRP commits from v1 into a single
>    commit, since the changes are small and closely related
>  - Fix compatible string ordering so the new entries stay in
>    alphabetical order within the enum
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


