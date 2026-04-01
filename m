Return-Path: <linux-aspeed+bounces-3830-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEC0D35176
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Apr 2026 11:36:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm2xF3wpjz2xfX;
	Wed, 01 Apr 2026 22:36:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775043361;
	cv=none; b=FxcpyCAbz6a0HW9aS9egttCGTuMPDofahkDH+QNswqlzzwvaZEtrsl4Vp+yWgiX8hRfEnt/2SkkDFVZRhPWKfvqicL8lbi4SwdF/WTByYK57wNWa6Qsu1BIL28z0JbQLMdFRmdoALpsj+Zzuii2in54zW5AvDJu27LDEEM8sqeydIa+bHiX+wWtk45AW355tgjJHoIMYw5K4RXVxPJmQfzPI5GGUuwTIqgMJ2eQh6jirN6SxT0pzA1YkPzk7aZ2bOoJmKOytot+nKTeHmxlQWeu/IbkeFh5QR/trSZEfQBp82Xm5K34aOyr1CmTu/MEVEQYK1WXZM99O2Y545h9f7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775043361; c=relaxed/relaxed;
	bh=Kwtn7E+4j95Z2DbZtdDe+NkpflDsdvdS9eNbZHrs5rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izpv+ZDuOk5Wx7Hj2PM+M3cvKUq+yizifyYuqvY5/QLY8gMEBSPG/Ruz/XhB9Jj7Y4nj3BctOdMyLIYQooofMClqh+Wr5dB+oxPP6+9tHilWTyDSDsq/QCfpVjUuKrHcGV7EnRqmg7EsJXsTRSlxcVh5Ew3FrmRRkue/aidJ7Bmdi+BR3X1b6FtE0qJfKHysJFhPM9gPRrW08SvhWR4kvXtkUDgkijp8E9nQC25j/47hmNn3WZaEP47LRhBJp4FKEFC4xBNzBj71y2LAnkSPu0Vo4ChBxXay1xAwfN4XJWII52ChZCuXMULBIN+vMxDcQuMxARHC9ZDv/2wneukNuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iBoUc3LC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iBoUc3LC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm2xD6dKBz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Apr 2026 22:36:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 47442408F5;
	Wed,  1 Apr 2026 11:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9D8C116C6;
	Wed,  1 Apr 2026 11:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775043358;
	bh=sff6V0+SikbFfnnkuOiFBlCiqZ50wVPswHcHFFLJGmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBoUc3LC2c+qN4fkZK6Cqw0ymOV5YmE554r9dGUUTJ7ePeCc4aTLdJZgHeyuATAod
	 OW7ZnFmtIf9go8WObN5EjT3d4VNpuWHpc+OoOUneqtbWJ495e1gwd2YwVJkKQH6osk
	 x0Q+9qVhVpqAAw/qGFTGKViqT9KKUK3AG8GNHtkjFmypfV4+YqaB5pFX724M4qxXBB
	 Tmbd/qV7OSfvVc2f/Ycm9o3HEdVCCR2nfka8SxXKibb+81Fxt4aQTBWqt1moenQ7Xp
	 e2ZDPR1I1gzD4nBNXkUd6NBG40yYSCwS1w60HKBZI1QsFyHoLCqdbSvMh4a5dQWF7I
	 B3N/vFNsrmt6w==
Date: Wed, 1 Apr 2026 13:35:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: soc <soc@lists.linux.dev>, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [GIT PULL] aspeed: first batch of devicetree changes for v7.1
Message-ID: <20260401-duck-of-striking-engineering-3bcfab@quoll>
References: <df8ef5ea7b9e254658934c18de20fd9805a82d74.camel@codeconstruct.com.au>
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
In-Reply-To: <df8ef5ea7b9e254658934c18de20fd9805a82d74.camel@codeconstruct.com.au>

On Thu, Mar 26, 2026 at 01:39:52PM +1030, Andrew Jeffery wrote:
> Hello SoC maintainers,
> 
> Here's the first batch of ASPEED devicetree changes for v7.1.
> 
> Please pull.
> 
> Cheers,
> 
> Andrew
> 
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:
> 
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed-7.1-devicetree-0
> 
> for you to fetch changes up to 76b4ec8efdc3887cdbf730da2e55881fc1a18770:
> 
>   ARM: dts: aspeed: anacapa: Add retimer EEPROMs (2026-02-23 12:02:22 +1030)

Thanks, applied

Best regards,
Krzysztof


