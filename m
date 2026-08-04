Return-Path: <linux-aspeed+bounces-4608-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E00C55822
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Aug 2026 16:39:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDzlg1HYNz2yLY;
	Wed, 05 Aug 2026 02:39:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785861566;
	cv=none; b=NqCT4P2c9Ma7bue3QKvHnmqWVGm67SumBxdR9MbiAStVf9S+vJ8tf9Ap3A+9xoU/HqdR1hcutu9zY9edu+6vOLX4YUvPqWMDtQbsLgmlLcwbTgozlutAQdKQPCIEbsP4WIa77ctCEPt6T3/bt+6TwNrqfAjdS/OixjVXk6tTWD3voSuIIgw6PyviBwgtFiw04pWuzg/bI6+MAXhWl/cD4fK2PfJHxhBB5qQpUAsTA2CMrL2xpCkaoT2ldAb8oC+vXTXhHtPoNrE86qW/g9sCiDfdsNUuKFhSpY3z7THZgWE1BLvS6/V4wadfDVK5RVfXCTbmtgk9IMcsfPggJ9tH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785861566; c=relaxed/relaxed;
	bh=C1Exlsw58tBiSkTE/438ODOUsmIy5tK5v/ELF0RItqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh7AXcznVlp9PVKk0A8/WQt1wclveao5ZIOXgvRiBuHATVmHjzS56taeAez7e2yVHExxi5IDwO7hztb6eEelboMw+FrqVWmyB7VPB+3ueY0C0zsYPfsOoP1Ut+Pbx65VjgkiHj0u5gGi/jTLCIrQOr3Ge+N+eEMjhkAEBWhknyRhb5FJ9pSmVPOvQyjZndX92kcXmy5CummMAXlA1IJtPfTo6eExW3Bn5y0p0jZDYxNJnUtGPQDhCi1TTCT7nxzPr4FBE9nd9stAnpo7JQ7qED7NNYwMMBXvqBHwntT2tmQau9wV6ndQ2/UAg22uNzNqrz4+zuwYTU/wccVzzyDNOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rl2FXhVX; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rl2FXhVX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDzlc5Fnpz2y1Y;
	Wed, 05 Aug 2026 02:39:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=C1Exlsw58tBiSkTE/438ODOUsmIy5tK5v/ELF0RItqA=; b=rl2FXhVXUZ7FykfYmPsp9ULuKD
	jtukEVV+SsrZHXqeX/OUCL8nH+GxZ3tprNx+XKIdXdo0okauEEgHV1ZaMmecAnVYxWFEsmXm8q5BM
	+aHMGdQuYk8yQZzHw5P8BDMKGzYB3LP4WkwFX/KHuz5D0SSmsErPCmIZt4M5ZavBHJVNCBAuKNxSN
	GKKkj1IMOUJ9qQnRY7VHG0I8q+Je2rHVSryS43zMJFUYMHyPt9QwKFUU4brwnZVDJiNMQ2GFG/byB
	i3JXqQjpT9xd5jRytvlmgdhk/R8MZxk6qg9jJKoYva6z2wbLk/I04ssNP+P56j9Hcd/vZ5eaShq6Q
	z26kOvQg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrIAa-00000002MYP-1pJI;
	Tue, 04 Aug 2026 16:39:12 +0000
Message-ID: <cba4de8f-0c4c-4c53-82c4-f6972cb4f4d6@infradead.org>
Date: Tue, 4 Aug 2026 09:39:10 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] Documentation: espi: add subsystem overview and
 MAINTAINERS entry
To: Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org,
 linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
 bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <20260804115259.4065638-4-krishnamoorthi.m@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260804115259.4065638-4-krishnamoorthi.m@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/4/26 4:52 AM, Krishnamoorthi M wrote:
> Add a driver-api overview of the eSPI subsystem and a MAINTAINERS entry
> covering the subsystem files.
> 
> The document describes the architecture, how to write a controller driver
> and a slave driver, the per-channel APIs (Peripheral, Virtual Wire, OOB,
> Flash), the alert mechanism flow, and the event notification model. An
> API Reference section renders kernel-doc from the exported symbols.
> 
> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> ---
>  Documentation/driver-api/espi.rst  | 213 +++++++++++++++++++++++++++++
>  Documentation/driver-api/index.rst |   1 +
>  MAINTAINERS                        |   8 ++
>  3 files changed, 222 insertions(+)
>  create mode 100644 Documentation/driver-api/espi.rst
> 
> diff --git a/Documentation/driver-api/espi.rst b/Documentation/driver-api/espi.rst
> new file mode 100644
> index 000000000000..60a3187edb05
> --- /dev/null
> +++ b/Documentation/driver-api/espi.rst
> @@ -0,0 +1,213 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +===========================================
> +eSPI (Enhanced Serial Peripheral Interface)
> +===========================================
> +
> +Introduction
> +============
> +
> +eSPI is a bus defined by Intel that replaces the legacy LPC bus. Unlike
> +SPI it is a structured, capability-negotiated, message-oriented protocol
> +with four logically independent channels (Peripheral, Virtual Wire, OOB,
> +Flash) over a shared physical link, and asynchronous target-to-controller
> +events, so it is modelled as its own bus type rather than an extension of
> +the SPI subsystem.
> +
> +Architecture
> +============
> +
> +* ``struct espi_controller`` - host controller, created with
> +  espi_controller_alloc() and registered with espi_controller_register().
> +  It is not itself a device on espi_bus_type.
> +* ``struct espi_device`` - a target on the bus, matched to a
> +  ``struct espi_driver`` via its modalias.
> +* ``struct espi_controller_ops`` - the optional hardware-op table; the
> +  channel API returns -EOPNOTSUPP for ops a controller does not provide.
> +
> +Writing a controller driver
> +===========================
> +
> +A controller driver allocates and registers a controller from its
> +``probe()`` function::
> +
> +    ctrl = espi_controller_alloc(&pdev->dev, sizeof(*priv));
> +    if (IS_ERR(ctrl))
> +        return PTR_ERR(ctrl);
> +
> +    priv = espi_controller_get_devdata(ctrl);
> +    ctrl->ops = &my_espi_ops;
> +    ctrl->max_targets = 1;
> +
> +    /* populate ctrl->caps from hardware capability registers */
> +    ctrl->caps.supported_channels = ESPI_CHANNEL_ALL;
> +    ctrl->caps.max_freq_mhz       = 33;
> +    ctrl->caps.io_mode            = ESPI_IO_MODE_SINGLE;
> +
> +    ret = espi_controller_register(ctrl);
> +    if (ret)
> +        goto err_put;
> +
> +After registration the controller calls espi_new_device() for each
> +target enumerated from firmware (ACPI or device tree)::
> +
> +    struct espi_board_info info = {
> +        .type = "my-ec",
> +        .cs   = 0,
> +    };
> +    edev = espi_new_device(ctrl, &info);
> +
> +On removal::
> +
> +    espi_remove_device(edev);
> +    espi_controller_unregister(ctrl);
> +    espi_controller_put(ctrl);
> +
> +Writing a slave driver
> +======================
> +
> +A slave driver declares a device ID table and a ``struct espi_driver``::
> +
> +    static const struct espi_device_id my_ec_ids[] = {
> +        { "my-ec", 0 },
> +        { }
> +    };
> +    MODULE_DEVICE_TABLE(espi, my_ec_ids);
> +
> +    static int my_ec_probe(struct espi_device *edev)
> +    {
> +        /* register for hardware events */
> +        nb->notifier_call = my_ec_event;
> +        espi_register_notifier(edev->ctrl, nb);
> +        return 0;
> +    }
> +
> +    static void my_ec_remove(struct espi_device *edev)
> +    {
> +        espi_unregister_notifier(edev->ctrl, nb);
> +    }
> +
> +    static struct espi_driver my_ec_driver = {
> +        .driver   = { .name = "my-ec" },
> +        .id_table = my_ec_ids,
> +        .probe    = my_ec_probe,
> +        .remove   = my_ec_remove,
> +    };
> +    module_espi_driver(my_ec_driver);
> +
> +Channel-independent commands
> +============================
> +
> +espi_get_configuration(), espi_set_configuration(), espi_inband_reset()
> +and espi_get_status(). GET_STATUS is optional: controllers whose hardware
> +does not implement the wire command leave .get_status unset.
> +
> +Capability negotiation and channel management
> +=============================================
> +
> +At boot the controller driver reads the target's capability registers via
> +espi_get_configuration(), negotiates link parameters (I/O mode, clock
> +frequency, CRC) via espi_set_configuration(), then enables each channel
> +with espi_enable_channel(). espi_channel_is_enabled() may be called at
> +any time to query the current state. Channels may be disabled individually
> +with espi_disable_channel(), for example before an in-band reset.
> +
> +Channel APIs
> +============
> +
> +Peripheral channel
> +------------------
> +
> +Carries I/O and memory cycles between the host and target endpoints.
> +
> +* espi_periph_io_read() / espi_periph_io_write() — 16-bit I/O port
> +  access; ``width`` is the access size in bytes (1, 2, or 4).
> +* espi_periph_mem_read() / espi_periph_mem_write() — 32-bit memory
> +  mapped access.
> +
> +Virtual Wire channel
> +--------------------
> +
> +Carries logical signal state (power sequencing, SMI#, SCI#, IRQs) as
> +indexed wire groups. Each group carries up to four wire values with
> +individual valid bits.
> +
> +* espi_vwire_get() — read a wire group from the target.
> +* espi_vwire_put() — send a PUT_VIRTUAL_WIRE command to the target.
> +  Named after the eSPI PUT_VW wire command, not a reference-count
> +  release.
> +
> +Wire changes from the target generate an ``ESPI_EVENT_VWIRE_CHANGED``
> +event delivered through the notifier chain.
> +
> +OOB channel
> +-----------
> +
> +Tunnels SMBus/I2C messages between the host and target out-of-band
> +processor (BMC, EC). Messages are exchanged as opaque byte buffers with
> +a tag field for matching requests to responses.
> +
> +* espi_oob_send() / espi_oob_recv()
> +
> +Incoming OOB messages generate an ``ESPI_EVENT_OOB_RECEIVED`` event.
> +
> +Flash Access channel
> +--------------------
> +
> +Provides access to a SPI flash device attached to the target. The target
> +acts as a proxy for flash read, write, and erase operations.
> +
> +* espi_flash_read() / espi_flash_write() / espi_flash_erase()
> +
> +Alert mechanism
> +===============
> +
> +When the target has upstream data pending it asserts ``ALERT#``. The
> +controller's hard-IRQ handler acknowledges the interrupt and defers
> +processing to a threaded IRQ or workqueue. From that process context the
> +controller driver calls espi_handle_alert(), which acquires the
> +controller lock and dispatches to ``ops->handle_alert``. The hardware
> +callback reads the target's status register (GET_STATUS), identifies the
> +pending channel, and calls espi_notify_event() to deliver the appropriate
> +``ESPI_EVENT_*`` to all registered slave driver notifiers::
> +
> +    ALERT# asserted by target
> +          |
> +          v
> +    hard-IRQ handler (controller driver)
> +          |
> +          v
> +    threaded IRQ / workqueue
> +          |
> +          v
> +    espi_handle_alert(ctrl)          [espi-core.c]
> +          |
> +          v
> +    ops->handle_alert(ctrl)          [controller driver]
> +          | reads GET_STATUS, decodes channel
> +          v
> +    espi_notify_event(ctrl, &event)  [espi-slave.c]
> +          |
> +          v
> +    slave driver notifier callback
> +
> +espi_handle_alert() must always be called from process context; it must
> +never be called from a hard-IRQ handler.
> +
> +Events and concurrency
> +======================
> +
> +Hardware events (Virtual Wire changes, OOB messages, Peripheral channel
> +completions, channel state changes) are delivered through a per-controller
> +blocking notifier chain (espi_register_notifier()/espi_notify_event()).
> +Callbacks run in process context; controllers deliver events from a
> +threaded IRQ or workqueue, never from hardirq and never while holding the
> +controller lock.
> +
> +API Reference
> +=============
> +
> +.. kernel-doc:: include/linux/espi/espi.h
> +

Describe each of these:

WARNING: ../include/linux/espi/espi.h:176 struct member 'setup' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'cleanup' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'get_configuration' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'set_configuration' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'inband_reset' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'get_status' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'enable_channel' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'disable_channel' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'periph_io_read' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'periph_io_write' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'periph_mem_read' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'periph_mem_write' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'vwire_get' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'vwire_put' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'oob_send' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'oob_recv' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'flash_read' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'flash_write' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'flash_erase' not described in 'espi_controller_ops'
WARNING: ../include/linux/espi/espi.h:176 struct member 'handle_alert' not described in 'espi_controller_ops'


or don't use "/**" for that struct's comment header.

> +.. kernel-doc:: drivers/espi/espi-slave.c
> +   :export:


-- 
~Randy


