Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94AF606A31C
	for <linux-aspeed@archiver.kernel.org>; Sun,  8 Nov 2026 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=j/fPd0cp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMfxn6yw8z2y2R;
	Sun, 08 Nov 2026 15:26:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794111997;
	cv=none; b=B8E0rQIcrczcx5qyNKAzbrWhsD/FLR5w5dEV6gfDaIhUCMfADoAZ+j5xWHuuwLefWCMA6iztCjCHEX3RwLAve8nofI1k1amrPPVW/rwzw5Nv0ooPzWLR4zet9YQb9rsZhynqeqTQkc1tFpwJMhz/VU2p/h8kPzuhmPkDuHK/kvuQQR/3MnKRiE+Tm9cuP2wfKVMcHSM9VGPacUc00+POOPEPxnx1X9VEG6ei11yFBVfOjzAVJpugcVWlPgHbrxUhrt+6TqvI2VpME1pwb2mRQT6ia2XB4WWWBMT5VKS4GleoTEJgI13PoEzo8WfDykWdRbqLzq0iYCBS7bVi4MYa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794111997; c=relaxed/relaxed;
	bh=8VwTVjzVBE3sZdY/bqGZDMPlbD8bcC2MNX+1REQD2iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAEB3ayoNUB+ul2B4aBe18IIvFXQwdZN9SCRvkiy8ShTISPrtFekvM70uKjEOZNCSCm0KTdP78Lg09q2aksAuSYEpbvWpvtqmb3y6fJKJkNvJhsuC/06JHWCShtYFRm5zP8YgmAEN+cu5o006HWBfgE0hLjzrYcoyjfAoa3X6ctryH0NL5+RgDObEXfj2rEexVKmaBdnbrXYjEZmlqtBXZn6UcA5TAzqom6b+FpQQnMN0gWKAwLOEvmiH4I04mgF9LiAId9Nhs4GzkIy/43/26Xi5cS0UtcDvg+NqTGs8gCSvllHsi6yzH/R94x79NXiomGyCt4tIVjxc1t71zDT/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=j/fPd0cp; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=j/fPd0cp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMfxl0gbhz2xYw
	for <linux-aspeed@lists.ozlabs.org>; Sun, 08 Nov 2026 15:26:35 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6707940E03E4;
	Sun,  8 Nov 2026 04:26:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iJlV_KB44njB; Sun,  8 Nov 2026 04:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794111980; bh=8VwTVjzVBE3sZdY/bqGZDMPlbD8bcC2MNX+1REQD2iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/fPd0cpOp75azdi04OqBwaDYMDz42+uOx7jGukqaYL6hEkmvaSknKfH/L/NnHVAS
	 zg2MSzp/1D7mtAUommgMgudvBaV93xQl2op+Z3GWaPmqH789VF6YoSYKO3IrjXU94W
	 XuykEaIKKW6CFpzhAL5ZI53K4XtAASiSRPG9xyQEx2rcNE5aVy3mUx/uNc/N+8Pzkr
	 malm2kWVu0RxSI6QZLFdViOkRSnInwWu3nS/VOV8htzR2gIuAkl0Wzvi73Nh22im5e
	 hrs7ipatT+6HaExvVM1AvnuuKwjC529EKZDESXbcGWuZxa6Wf0MsI498ibURbkQStA
	 yrTzb6OqY1IRGxLaynj87/34z9RHY8zCRiG9p9R9Nkf6+2De4VzGRdQZtuHQrvbDMT
	 MRlS00NaOpXBYNRY916hk2RpChIMJUzm3m3ZO9lBhg2fXBNHykXJBZmOCIA8yhzkdy
	 hzBd7K5TU6peqS7lfRctFM4u9yeRCnHKBad2wK9Vx5RuXZKcWXnfx+rs1wdcXZLc9c
	 IXBSG0WU0m6qbxknguYzFejbsfKcvtozANdRr0/7ntAdt0LMI7IzbLo73RC5iG3KWd
	 mQOtv8jZU+dkUhXfrgc1z5TrQUtygVXCtVfoIW9TIS2a0T84uUQV2kyxuXRj5N7/aw
	 zpz/lOvcIgb/ADvrBhNC9yOg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A28EB40E01E1;
	Sun,  8 Nov 2026 04:26:05 +0000 (UTC)
Date: Sat, 7 Nov 2026 20:26:02 -0800
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
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 6/9] EDAC/aspeed: Replace regmap with direct register
 access
Message-ID: <20261108042602.GDau_52vqJcQSrUAf0@fat_crate.local>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
 <20261007-edac-v5-6-5c31fc5df4cf@aspeedtech.com>
 <20261105045635.GBauwMg0oqd2tVPH-4@fat_crate.local>
 <TYZPR06MB7920FD1C150DCB201DB88367F2742@TYZPR06MB7920.apcprd06.prod.outlook.com>
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
In-Reply-To: <TYZPR06MB7920FD1C150DCB201DB88367F2742@TYZPR06MB7920.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 02:01:45AM +0000, Ryan Chen wrote:
...

> Patches 7/9 and 8/9 follow the same changes.

Ok, pls use

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-drivers-aspeed

to put your changes ontop.

> Thanks your help.

Same here.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

