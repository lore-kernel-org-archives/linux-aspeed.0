Return-Path: <linux-aspeed+bounces-5032-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4952CC982DF
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 03:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hplhS3QNPz2yHT;
	Tue, 22 Sep 2026 13:19:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790047192;
	cv=none; b=Yi8nry9b1PtQu6mRvWsIJiVFgphs5NTqWH0dxGsVAQE0wVq/VnoVdmqEWuJ4xJ033h3rbDpo5+2iUqc9Oswn0TnkYnzHG2BKMZcPoIc16TsxoS7UqhLadoMeBD2jLbb0YrlRqOE2/eYqHr1PKyKHYRu6NEHyVdUUTykSQV6rNEzKtAkHPz9WhCsTlg65NkLZEtKl+hHJ99GIhISZrtEVyHwwLZua9QUx4FGCIPGirmJnwdcvFUuMW9aUmYnGc4S9M4bQx3lMYvUdKNSrOnNhhXuO1viR0Q5HZV1YxbH1LTG3YReCh4HUqBIta1ODI2pxLVuLqLtRgnM/+X4ifKGiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790047192; c=relaxed/relaxed;
	bh=+MKL1A4R3bj6tzU6UGWcVJABH4EcohmMeq3pEKdS+EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwqJssIBE7UmSSJQPTziLJqs9gzUjK8Q2xLIFBAQPqSd8eSnnKeyEpHvVPW0an24T2r63w866aOU6jGGbLKODLvPoMAazkkQQJP0BHNd/xDXIDQi6ckrCSHR76hJoRGTAN8k+fUMhLnfQPL4sTbSv8MG6NEi9W5eTndbMlpPcHGZ4Wt1iosfRajYR07MoLarxKaW8gcdd9zlGIOEe3oxz3ljlVVSGmDBD1RJBiPeGdbhKUCen3wRgAX5STuGC9em1SwR8EySbNM06zFAjvHDdUboKFrvutGXuZoXk2D/bdl05+0eVCMRCl7HaPeetXnST7SEGSCIMsXlaQTzxp2Iag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=NROCxi8f; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=NROCxi8f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hplhN4Dccz2y21
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 13:19:48 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 954BF40E015B;
	Tue, 22 Sep 2026 03:19:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i5h7Is0JHuso; Tue, 22 Sep 2026 03:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790047165; bh=+MKL1A4R3bj6tzU6UGWcVJABH4EcohmMeq3pEKdS+EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NROCxi8fKsSU5IFC5pckp3DPHy9lgrZwR6J26wTEgFH/HwUnuPD3FNMhS92LThXNG
	 HskeP4nn7sNjj9GYR8pv3Esnu1UNHdBo3dxhO71FQcEletNh1Rgy1rebPJWnfLByBw
	 VEEsepMpRLcKdFy3+kZid9tjgwOIX2o1cPNqoPHxmA2NjWzZag+H5/bOLESWmoxXW+
	 iSiJ0FWPQ5HtN9XRgOlwt/fSgEd/BFsTIbJdTdNlwPLjWjJXA8zNMcUMaJ+rsJYJIw
	 D/2vpEENdbpqZMymCObP+AzuiXozkVhyu8N95wbT7EjxK6/OeoJDXzUGJRs7J6SvWO
	 K5PbDwNkWAKcRoRLqFRQJ2+iAbalbbn0azBTZZR37yVkl71V28Bz5ds80C73DbDVVk
	 nsrJPlvyNVIWTcaqe+k5e36AtCVWXl5zn9diINp8pM8SEKUGyFJ5jrxJtSj+blqbwv
	 z2CCJChpG+oOiJcWHpXUTgKzImbuOf2zlsf+63pPv7Pu4lT6YuvWjjus70JN4L8skN
	 CyjsI787KZhSthXEwrfuascYjcq1R9b1XNkMJxNYp+u4G4lvGjCw286RwMNpSzHWGh
	 2/x0kGdCxOeLIv/BM5W6b5vylt/DgfRh4KuoDNc3kMgiG2AwaHyEAk4yNGs94xV/sw
	 ro3pa+y+mHLTMUL7ogGaZyw8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF31F40E00E5;
	Tue, 22 Sep 2026 03:19:08 +0000 (UTC)
Date: Mon, 21 Sep 2026 20:19:05 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Message-ID: <20260922031905.GEarHzqf56ypqALDHi@fat_crate.local>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <TY2PPF5CB9A1BE6D0247845980A7BD60E60F2832@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
In-Reply-To: <TY2PPF5CB9A1BE6D0247845980A7BD60E60F2832@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

Hi Ryan,

On Tue, Sep 22, 2026 at 02:53:27AM +0000, Ryan Chen wrote:
> Stefan has resigned from the EDAC entry:
> 
>   https://lkml.org/lkml/2026/9/20/1295

Please do not use rando pages from search engines for pointing to patches, we
have lore.kernel.org for that.

Also, please do not top-post on public MLs but put your text under the text
you're replying to.

We have the whole development process explained here, please take some time to
read the most important points:

https://www.kernel.org/doc/html/latest/process/development-process.html

> That leaves his patch and 9/9 of this series touching the same lines,
> and the entry ending up with a reviewer and no maintainer.
> 
> You suggested a reviewer entry first, and I understood the reasoning.
> But with Stefan gone the choice is now between orphaning the driver and
> someone taking it, so I'd rather ask again: I'm happy to take the M:
> line. I work on these SoCs at ASPEED and have the hardware and the
> documentation for all four variants.

That's much appreciated but you don't have to worry - the driver won't be
orphaned and you'll be the reviewer and tester of patches for it. And I'll
simply add Stefan's patch at the end and amend the hunk marking the driver as
orphan and instead add your hunk which is making you a reviewer.

> If you'd still rather not, that's fine - tell me and I'll respin 9/9 so
> the entry reflects reality instead.

Let's see how we work together this way first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

