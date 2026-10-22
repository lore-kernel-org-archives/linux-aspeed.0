Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7A606A325
	for <linux-aspeed@archiver.kernel.org>; Thu, 22 Oct 2026 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=hMx3kx2u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9bKn18B5z2y1W;
	Fri, 23 Oct 2026 06:09:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792696141;
	cv=none; b=kt+GCP2UIrXiE+boZ0LT+A3X2iwuqbuMI11v22N5OqajU2nzfz8gkpDld4ZVIx6IVM68qrG1WLXT+T1p/bNnYHMC16VHPAxIrzkg84PaWwpgZvSm++bDCT+gBv35Udie4ygblul/9j849SrfIE8FIC1D+2BnY9ADP0Plxgq9ueRtFFteoeIK5YMxMeYPNKuRyt4vLe4G5nuX4+n3lKdbwNU52Xj4SG1pbxyFYKcr5uDv4O/RCb+5xBLV0bl4eKnbj2tPlsiRWuuyJOSTpOROlFPZthw8Qvz9TXWMF7Yg9TixZyw6AygLiwGr6f7eXcMaZM9EkwPfF2heK7XGT8vVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792696141; c=relaxed/relaxed;
	bh=d+IRbs3FeqA37fXeROEiKyHno8d9zy8yIxQWW2C+tuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ14mV9k6MOSlvqrXgjd0Xvqqd3lMpr/ylbQMELiBkUlMcg92TioqYdioREZOzI8dyxRpeGXOOiOyMCroL47gJL1e3eC/zI3PesFfc4ANej+5+aoWpr6AZ6n68GkdWDQj1x//jW4AIbh891J9XbB/AAYNktVq2/lzUFeAntGGYKFeto5vFrHFT6ahbMW92vkBXuZNF1dP1QTKMk1yw1Vot6fdbUEMz6/eRxbQDuWmK0U7OMQFNHbwVKx5GGjin4ZwgHJ5eVRb618hZpYwzXkEzmekc8M7ZdBVTe2uJ+SzYeP6rX/MSZ4tyvcPp+oKTfNhYLOp5KFA8LYaoKtefdDWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=hMx3kx2u; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=hMx3kx2u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9bKk00CNz2xwN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Oct 2026 06:08:57 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2540740E016C;
	Thu, 22 Oct 2026 19:08:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QVTxtbd_px1P; Thu, 22 Oct 2026 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1792696120; bh=d+IRbs3FeqA37fXeROEiKyHno8d9zy8yIxQWW2C+tuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMx3kx2u5Yv12yYwRnZIj8ko41SrEY0/Bo24yD1IkaXB3w0Cduv/+/mZALYiTB1c7
	 ljjfmrxGeDxztfA7wvUouPo7jX29EoogFB3E4lCS4jQ8D52zyU62aHlDAlJAs1GO5X
	 Gqyg+Csp7RMyGnOeVI1L0OJodlzLQ52GA0ajToo8k+DBUjpRRzVsi3eMUWjfAQxNwp
	 3LmFfL6H1eDU1EDO9Ixj6jX0p1x/ThQfPKXHEpNgFUAS7Qn20cMOD715Lbw3XO79FH
	 adaQ3dlCrkNZu+IcSTHZW849r7wmXSICNIF2yl9TYCzQTodWgcYqKuJBX9Da/xeyt9
	 DzDAvwtI6/PwCNVaCM4TMMWNNt5jvXQ0yt4AUTbQ+NEeWMwAO8+k9Vx8kguPHk58m0
	 FFlWKMwpgsJQ6J97aAdrFKQcAN0N9Fe5Dbpf1LWhd1gGcpBbP0SreR2Nqj9i/SDHcO
	 vsl9S1wNoXpSLNG8/60rkaFfEQRl6oPrWD2YwB/c4H0lX77G2c6dNVEqTMmS1sirxw
	 y0QmbcRQjNu3D+20Vx9kkvi43ZRkuM08HJvV4Hs5BqhipIVG6y+Z2+nuBkCWqZUxzl
	 Ukr+sL/72S9yWdkXaQBA3XEatB4/zUgEqiORrYh0k+vVOYPPG6qhkuxpYgRIrtxFts
	 3ZcV3/WTjJYy2zQ0cM0Xzm+Q=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5237B40E029E;
	Thu, 22 Oct 2026 19:08:24 +0000 (UTC)
Date: Thu, 22 Oct 2026 12:08:21 -0700
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/9] Add Aspeed AST2700 SDRAM EDAC support
Message-ID: <20261022190821.GAatpfJYsT2fqKhk3T@fat_crate.local>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
 <TY2PPF5CB9A1BE6C09C55652B1A6AA68725F2652@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE6C09C55652B1A6AA68725F2652@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 09:52:36AM +0000, Ryan Chen wrote:
> Hello Boris,
> 	Just a gentle ping on this series.
> 	Any feedback would be appreciated.
> 	Please let me know if there is anything I should address or revise.

Lemme give you the spiel since you're new :)

From: Documentation/process/maintainer-tip.rst

Merge window
^^^^^^^^^^^^

Please do not expect large patch series to be handled during the merge
window or even during the week before.  Such patches should be submitted in
mergeable state *at* *least* a week before the merge window opens.
Exceptions are made for bug fixes and *sometimes* for small standalone
drivers for new hardware or minimally invasive patches for hardware
enablement.

During the merge window, the maintainers instead focus on following the
upstream changes, fixing merge window fallout, collecting bug fixes, and
allowing themselves a breath. Please respect that.

The release candidate -rc1 is the starting point for new patches to be
applied which are targeted for the next merge window.

---

While you're waiting, you could read

https://docs.kernel.org/process/submitting-patches.html
https://docs.kernel.org/process/development-process.html

and you could even help out and review some patches yourself. That would be
the most awesome help you could give to folks, and it would be very much
appreciated by maintainers who are drowning in patches.

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

