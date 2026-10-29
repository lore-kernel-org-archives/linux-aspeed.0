Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02B606A32A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=il82Uc+P
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFYsC674Bz30NF;
	Thu, 29 Oct 2026 17:16:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793254591;
	cv=none; b=cGKy8qWmnOlEiNf0lVmY1KQoPJXV/TzpY0ZvsWsRBKVcdUZ9LK5bO7Ue3ji+8QGOh0XfJxORimzcTBFNmuIydR9FupJWDFAfRYyOfXIHWQEvOXWiQqEvh2r4IpvCl4DehsxMJKlS7hr36TW0voNoRorx3A1J46hPPBqHrVcgz16xknKkjfWwIl/rAjwWeZkDWRSjAwIon9T2K4RP3aPsPkP3awO3qKvD1q3Dhv2QojK5V5dk4J+rA67rroaaa9rYwohEpuwrLhQpAyfzprxC6qRQ1i2vuqR6cz5KPR+bQ9aK/sU1jETksibOJxS+pfofIGwm1nqn7+G907FEMVCc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793254591; c=relaxed/relaxed;
	bh=mcrljsIymRV5+ffp+HQjRncEcwBUUlAXl9/IaAP6MUo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZTahy/zADW/pDDlHBCtsAETOoTuzziivIWIEmlZNugBpdwhElsVgUelbRaQHjj3zqvSJCW+46bu4UCo/WRuCNGXCeGdvied7grAASnuWODgP1ZoeEru8PB0+OC+zGa6aU/UeRbgyoq+TlJ3eF5wjnZ3W250GL4UGEjPaIicfLYek6gO+hVQxMnKWOh2hf4pMjy9srgS7J+irShrFPOVigEs1cRJoMB+89J9RgoV3WkfM8knRPD+CSAe+M10IaR9NQljlCJD2tOmnAu4cOUZ6Co3bGRPqaotJNnWDARtrjIUEcFj4YxmV2WIsH9Uf3BpasD8nXwjpozY53IFb5JRzhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=il82Uc+P; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=il82Uc+P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFYsB188Nz308H
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 17:16:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6DB0E402C2;
	Thu, 29 Oct 2026 06:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3355C1F01825;
	Thu, 29 Oct 2026 06:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793254586;
	bh=mcrljsIymRV5+ffp+HQjRncEcwBUUlAXl9/IaAP6MUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=il82Uc+PYiujnvTAx8vOogC0gI21PjTlyoqALCkM4BKfou7PHEjfs5eXMVf6rQLmD
	 r7l0jWwU5dMM7C1QnjOOEd1RybLgmxLXiAi85uSi1QAkVaUa806EpdyEr5k/sSbrWD
	 lzOnoAH3WemowZUWDdb65jcZuha7B4Kgx0FVU36Y=
Date: Wed, 28 Oct 2026 23:16:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K?=
 =?ISO-8859-1?Q?=F6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy
 Tsai <billy_tsai@aspeedtech.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 00/10] treewide: switch to __nonnull_args() macro
Message-Id: <20261028231624.ba38137c3ba142785c75de78@linux-foundation.org>
In-Reply-To: <cover.1793027261.git.d@ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 08:19:39 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the __nonnull_args() macro to wrap the raw compiler
> attribute, keeping the attribute's quirks in one place rather than
> open-coded at every call site.
> 
> This series replaces the remaining open-coded __attribute__((nonnull))
> users with __nonnull_args() to standardize nonnull attribute usage
> across the tree.
> 
> Each patch can be applied separately by the respective maintainers.

Thanks.

Standard routine: I'll grab everything.  If maintainers send along an
ack then I'll add it (thinks).  If some of these patches later pop up
in linux-next then Mark will inform us and I'll drop the mm.git copy.


