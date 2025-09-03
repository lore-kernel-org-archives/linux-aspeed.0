Return-Path: <linux-aspeed+bounces-2134-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4323CA0FF2
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 13:40:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cH3df375Lz2xrL;
	Wed,  3 Sep 2025 23:40:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756906822;
	cv=none; b=cQ9lTWzz9IbQM92wIN4FzyhBJJIBlJIh35qJV2L0GNX30DqwruWI4kTcZMXhqfyl04JmneaobEzaK0BAQp60qeve5gOQ8BbDcYZcjdeafqGV/ADFUj5U8kLMNO+UlBPksfi5L6j/TLZ9rhzGMkRc4v+unDicL0pSSq3rmWPsskrYhx/FhX5faS51zwGYZU42sq+FrcqaKkuVK4ZhL/MisUcG7/sdAfRd/ZC6Whx1Bj9vL+Q8E57NjWrwKx3Nw77NSGIo6aD08ZzOjmqrIcbNYS0JwUCvlsTr0s5TIq7UMnEt2lZqlxHnU1Nti6wJkUSReJiMU9AARMqgpPAYcXx/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756906822; c=relaxed/relaxed;
	bh=lvv5D8mnkMTlnoYs3i3HuxRJ3lgI3ZhGxgUn/QmY3UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKcpvOEWuIa5kZL7LI7nJxDp3aYnt83qzoJSVJZ58hpiTCOu/Km9rjjrrKeCr6RgUbGIunbtu4+jXkctcBuHKcMS4zononjsBkcdb68tllTx69VBtic9+oaq7OvMC2JomFmfk5JUyi3KvROD8uZnMulyR7O5yz/HCGaNXCeeALbC6Cf5h7lTvcb1G+4GYDGCYJ3YvtQmg2R57biF0pmCDwtp9UjkrB0SgjcQWUoyJAJ/RM9WX/ISQ+n4yseS36G58mBNgWSGfyyCbO2HFkln/ziSginxQI0BldpnAvPpmaKpL0o4DpIxdUPkiZytqjnP2LtrVnS/2biVycAZdHlMNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fGnE1oZ+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fGnE1oZ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cH3dd5BLkz2xlM
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 23:40:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D1D2D416C7
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 13:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E23C4CEF8
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756906819;
	bh=lvv5D8mnkMTlnoYs3i3HuxRJ3lgI3ZhGxgUn/QmY3UM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fGnE1oZ+39/GuuoRDaaTkt8MY88oEZU5KWK1TUP3Wr1jdXKmEgQIkCCuj+DkbZZLJ
	 85aUZR0NHrhz3PIWsZTLVJiIFkYbd53gnDJmFxm/bObU3P2udHHEbRa0tztPuSdNKu
	 ew1FDTCuquP/YVUMFlzLHuYnTaxYOcbz5pHm6O+zCGMhZ9WdU/9Nn40wP1Y/PjWfSq
	 FbIg9+gIJdb4zfVUU1kHSu6fuYjcS8TPsnWGMQ10yoWh0blkYIyayjZO8QZqIlAbk6
	 8a1D5zZubfGAeEYGozDY8IyEXKEaBDz2+TIdhlW2XPassEPrCXyH51+mCmy9PXwmzn
	 E4dcNNhICy7Hw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61ce9bcc624so7716174a12.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Sep 2025 06:40:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnd1cK0uydV9YCcivhLRp5/OXYVsO5XNG+L1QkC6NbPl9QH31K6JWs/0EbebA2x+SreafID7HQQCTMLT8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyB/wy972dtwWUEZmRgxJdw6N2lXjuGxWoDHT54g8YcuUM7PHPh
	cp13iPO+6p3gtHjhLi4xSeVtoS0/GpfSs2YtQeJ4FKHPqLKaYUHadkwtfRlTzS7Wu0ImmuJGQ4t
	ImGBOnHpejK/Wc3S8zWCXFijNS2N1yQ==
X-Google-Smtp-Source: AGHT+IEI5rONWAGmUuQ0T6juo/pf8XchiICM5ct7ySlMdcsLqlsl5dtas428fYuAutHdVTYx18c+P5yWiK2OhZsk7uQ=
X-Received: by 2002:a05:6402:2547:b0:61a:7e43:662b with SMTP id
 4fb4d7f45d1cf-61d26d78762mr15929022a12.27.1756906818326; Wed, 03 Sep 2025
 06:40:18 -0700 (PDT)
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
References: <20250829211330.1336274-1-robh@kernel.org> <0c815a7562551caf3960cd38b5d867c80747de4b.camel@codeconstruct.com.au>
In-Reply-To: <0c815a7562551caf3960cd38b5d867c80747de4b.camel@codeconstruct.com.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Sep 2025 08:40:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmTmb3GF+CvidWhzgoDP60tb=BtggMcyEP_Ev9dNtjAQ@mail.gmail.com>
X-Gm-Features: Ac12FXwNsWO5DYzNPykwatojxDlJys_qPpKp_KZ_wSvZHEoXKmrvoXoQmYLtNWw
Message-ID: <CAL_JsqJmTmb3GF+CvidWhzgoDP60tb=BtggMcyEP_Ev9dNtjAQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Drop syscon "reg-io-width" properties
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:18=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Fri, 2025-08-29 at 16:13 -0500, Rob Herring (Arm) wrote:
> > The default width is 4 bytes for "syscon" devices, so "reg-io-width" is
> > redundant and can be dropped.
>
> I had a quick look in the syscon bindings and can't see that this is
> documented? The driver implementation behaves this way though.

It's not. I suppose we could add that to syscon-common.yaml, but
that's only documentation. It has 0 effect on the schema validation. I
would guess we have hundreds of syscon's that rely on the default.

Rob

