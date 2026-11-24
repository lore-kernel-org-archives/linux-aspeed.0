Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AD606A31E
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Nov 2026 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=dxtTMzrI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYNzP0rk9z2xfX;
	Tue, 24 Nov 2026 11:31:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795480305;
	cv=none; b=jLolP2z+blIH6nYO/tM+GI0s/JEW4KcgcZVcy+k0iqw94Gyf74n5gOkwD8xOY4bx2jhHkoVKxNYBrEhGcFukZBxuzEIBgd1zJ7XhoF3rBqTRohODpEkUGW7OlqYROClq+xsCQaQnwEAufDFnMDU5H21H0kuD5mpZHHP93Uqb7xHK2twpRYZFkztsZWhYVQhuV9AelAJVETe6RI6RlMseoNlZ9MiMNPuHYzwA6vXSxQIJdDY9iAFEQ7dL9MigWdFjZ1qt8EfU8tdL12iXUrWt6h7vsmGpVfilsNEHhxZvHQFqJb7ditPF2+5M3iNqzVTTuAD6akF0t6iXphcci2THuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795480305; c=relaxed/relaxed;
	bh=7IpkPkVFHEadLY409nUalcnMRClqdAQR7VTRSz1ZcO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOGVT0U+05rU8K5wkayqHcIk24D1njG8/AGhjVdWBvOFXYzNFlIv1Cz2ndnpYsKyfS1hhSK66CMLbtqVnXr0aizfWT292eyOVZHX0c0TOIpl83aeqwtXPkDtWP0IwISIfnNVupkvLJ5Iv6lZ7oUA3gsWIx/NOgp7s55UJnFzmyAvkszDKcdLAyuduPP1tIsra5wIfRBDa1L5qzRdRY1t12/FEJ/DZ3r3dsDyQadORT/25d5CRDsUyn5TbZUEap6ThCYO2pvw1XqBEuCcGyWBfWu+mwhSoIOg0tkfIH24+b3mJY+xmT6cOhk1nNVDr/+lF5V43wxy/Lhw43+gMXHSmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=dxtTMzrI; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=dxtTMzrI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYNzL1GgTz2xf8
	for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Nov 2026 11:31:40 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 025B340E02AA;
	Tue, 24 Nov 2026 00:31:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xKx_-KTIfSpn; Tue, 24 Nov 2026 00:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795480289; bh=7IpkPkVFHEadLY409nUalcnMRClqdAQR7VTRSz1ZcO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxtTMzrIL2fiuW2uuAg3o2TZ7OmmjPyRs4XTm6+40JI43cDYin4TG1Ke8hvvdeOE3
	 6VG7vmghoywou2l3QfBlsSZU5jaKZwecLlfOjb/FNHgxaYyBvWTRdNjlBqQlNXBn0f
	 V6QGk4z05IY5zZMYcoWYkMnjBmIXdyoCoJ7DYF2R7rPJY7QSObTY5zBZigUEH203Ys
	 tXd5zqDVZA5syLn/Zh3fu+xApkDk1GBT5soKeVyvicfMGZ3RqLZhpkf8DSGmgWhzqg
	 RwDFltz3o9zqd2Jt1MlK/Bqm/OlH1BZ0ZAkIzIcEUMjaf0j+fSsmEufdA1a2qG74fl
	 SPKkcYEOplQX7bntkepvRlsTHKrYWUGIxh86h69Zjb0olSEsXO8M1BLxnpbqtQNOjt
	 qvpnfeWTlaYTckcl1ggafe8aCh9mMzbf3/+etfuyv9BhcvUaK3gHV2KA49g2cV/A5Z
	 rlZx9W+idJ2eEFHHWOWSo+13fZM+3L0F4+Zm43SI/6RTzonngU4uZxRKoCHjgjt+4k
	 2avTfLz7xn0sKUaTteGBWjNYj8INDKK9ddwqE3Y5xZdNCZ1u+JT4D7saRDTkjIaGJ6
	 AHYoXdF9Rrqdu6xQtkEKC7XeRX3ZMCt0Dlp0bijOwauJ2ycqiAq3+BJWSH6FGnNxH3
	 wetm2jf087EkhHzioUWE3XQw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E18E140E0240;
	Tue, 24 Nov 2026 00:31:13 +0000 (UTC)
Date: Mon, 23 Nov 2026 16:31:10 -0800
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v6 0/4] Add Aspeed AST2700 SDRAM EDAC support
Message-ID: <20261124003110.GHawTazmnfEiwzjh-0@fat_crate.local>
References: <20261117-edac-v6-0-a2a747b95c3f@aspeedtech.com>
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
In-Reply-To: <20261117-edac-v6-0-a2a747b95c3f@aspeedtech.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 05:26:37PM +0800, Ryan Chen wrote:
> Add ECC error reporting for the Aspeed AST2700 SoC to the existing
> aspeed_edac driver.

Ok, I thought I can fix up small things while applying but there are waaay too
many issues.

1. Split the biggish patches - a patch should do one logical change but yours
   are doing more. Do not do any drive-by changes while adding driver support
   for some new chip. They need to be in a separate patch. If not sure, refer
   to the documentation I pointed you to.

2. Write your commit messages in English do not use made up terms like "DRAMC"
   and "isr()" and so on. Those should be readable by humans.

3. Do not explain the code in your commit messages - only the non-obvious
   stuff.

4. Do not put in the commit message how a patch has been tested - that goes
   below the "---" line. I think I mentioned that to you already.

5. Drop the "aspeed_" prefix from all static functions - they don't need it.
   That can be a final patch ontop if it is easier. One logical thing per
   patch.

In any case, tell your Claude to do those things because there's a human on
the other end reading and human does not like it when Claude does a stinking
pile.

:)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

