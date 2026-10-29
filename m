Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9FA606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=WUo05cr+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFzWK1N6lz30Sv;
	Fri, 30 Oct 2026 09:32:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793275753;
	cv=none; b=bM2wTWivXu/ASTRXnxpbkQx8AN2/uawz5J4BgCV4qeYGduEtOPmZ1tmeQuR8KIxmvxVrjokWz8DqC/ytGB1JKTr7WTZFYsBN9uN/y5HfHOKb+WQfA/XdIE1jAQIE/pwf9isglBH6RKgmv0y8DbMrFXURV5gF2xR79SXmcfNCt6ZaeWoYoZR8ctaQDaweSaXOHzTelGzNLEQE6Blj61BRQ+MVVrUYhyi7gh0aLm6sUIeJD8l3qFQEwHCdAYTbtbgqyWsEjTq81y89Re6HLywdvkEI0BZyeuZ8aCcJL7aTCV8ym1kpc5wqldUK11gj0E9g+swZxUAqcF6i9ubQ1V8NzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793275753; c=relaxed/relaxed;
	bh=RocjA1LFJ8nCgW+tO2y+Fh4wXXWjfdPFo024IhF5Wq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqcWTlscZ1UcdyspxeClHd/8xzaGqREbLguKEjUyBgHoiZr5d9z4cJxlyhWQ0/5CAYKEbQO6qX8HuqKN5FaxfgoZodBGHmg0TL4OPTvH+xL1JYDbfAKPfYVozwLC/ySpDFWGiKczF4JtrDnCUWiM/fAi3+ioag2pfEU0Jbi69BxspSUTOVSXcaHbdNkxeu/peijFo/y8mGNeP7O3yieAQ/9qV03ZapjDVpTIDGx32cQC2WukxjOC7cEDrdLQAs22aDhSoq3ceS6mrO8iL+aHAwi3Vzj+JmW0ixDWoAWTfSXo2G1ljax8fFZ+o4bVdFeTrW2YouyDqWr1J/ph5qe2kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=WUo05cr+; dkim-atps=neutral; spf=pass (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org) smtp.mailfrom=ilvokhin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=WUo05cr+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ilvokhin.com (client-ip=178.62.254.231; helo=mail.ilvokhin.com; envelope-from=d@ilvokhin.com; receiver=lists.ozlabs.org)
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFjh81Gydz3048
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 23:09:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1793275747;
	bh=RocjA1LFJ8nCgW+tO2y+Fh4wXXWjfdPFo024IhF5Wq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WUo05cr+foO7RPlP7534YSiBgZ8CQPkwQY40XhGkYZY6+6/4j3XkS/IFDfGv+Pkoh
	 y9zJIn2BFoMmtdWooRjNBcjjjJtArbTwyJLsxt66JLoWE/gVCnnA7sNVi3UolL8xve
	 VDmnu4pCCOxy8JC/MQlwNqsBS6P1OvE3N85vIIf8=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 2E446101220;
	Thu, 29 Oct 2026 12:09:07 +0000 (UTC)
Date: Thu, 29 Oct 2026 12:09:03 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 00/10] treewide: switch to __nonnull_args() macro
Message-ID: <auM3XwWPnMHcPptM@shell.ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
 <cce30180-c1c4-4b10-b681-8944057bc698@infradead.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce30180-c1c4-4b10-b681-8944057bc698@infradead.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 01:44:59PM -0700, Randy Dunlap wrote:
> 
> 
> On 10/28/26 1:19 AM, Dmitry Ilvokhin wrote:
> > Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> > nonnull") added the __nonnull_args() macro to wrap the raw compiler
> > attribute, keeping the attribute's quirks in one place rather than
> > open-coded at every call site.
> > 
> > This series replaces the remaining open-coded __attribute__((nonnull))
> > users with __nonnull_args() to standardize nonnull attribute usage
> > across the tree.
> > 
> > Each patch can be applied separately by the respective maintainers. The
> > only dependency is kernel-doc: the string and lib/list_sort patches need
> > patch 1 ("docs: xforms_lists: support __nonnull_args()") in the same
> > release, otherwise strends() and list_sort() drop out of the generated
> > documentation.
> > 
> > Latest Sparse release could not properly parse __nonnull_args() without
> > arguments. Fix was proposed [1] and merged, but until updated version of
> > Sparse will reach wide masses it might trip on __nonnull_args() without
> > arguments.
> > 
> > There are few more instances of __attribute__((nonnull)) usages left in
> > the tools subdirectory, they are perf related copied files and can
> > (should?) be updated separately after this patchset lands.
> > 
> > Build-tested allmodconfig with GCC 11.5.0 and clang 22.1.8.
> 
> What ARCH(es)?

Fair point, I should have mentioned that I run this on x86_64 and
aarch64.

> 
> Did you mean to use such an "old" version of GCC?

There is no grand plan behind that to be honest, I used it, because this
is a version of GCC that comes with CentOS Stream 9 on the box I tested
the change.

To be on the safe side, I checked patchset still builds on GCC 16.2.1 on
allmodconfig x86_64.

