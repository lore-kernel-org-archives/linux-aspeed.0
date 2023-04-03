From: Wang, Wendy <wendy.wang@intel.com>
Date: Mon, 3 Apr 2023 01:49:54 +0000
Subject: One ast driver reported in bugzilla 
Message-ID: <DM6PR11MB324495D75DFE7B53B7349C8F9F929@DM6PR11MB3244.namprd11.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

May I have your attention for one AST driver bug, which is detected on Intel Emerald Rapids Server.
The bug is reported on Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217278

The issue can be reproduced on both mainline v6.1 and mainline v6.3-rc4

Here is the description:

ast driver will trigger unrecoverable kernel panic during S4 resuming.
If add "modprobe.blacklist=ast" kernel parameter to disable ast driver
Can avoid the kernel call trace.

[  456.012967] CPU251 is up
[  456.015985] smpboot: ++++++++++++++++++++=_---CPU UP  252
[  456.022183] smpboot: Booting Node 1 Processor 252 APIC 0xf9
[  456.028552] smpboot: Setting warm reset code and vector.
[  456.034650] smpboot: Asserting INIT
[  456.038648] smpboot: Waiting for send to finish...
[  456.044128] smpboot: Deasserting INIT
[  456.048334] smpboot: Waiting for send to finish...
[  456.053818] smpboot: #startup loops: 2
[  456.058131] smpboot: Sending STARTUP #1
[  456.062542] smpboot: After apic_write
[  456.066768] smpboot: Startup point 1
[  456.070898] smpboot: Waiting for send to finish...
[  456.076398] smpboot: Sending STARTUP #2
[  456.080832] smpboot: After apic_write
[  456.085082] smpboot: Startup point 1
[  456.089215] smpboot: Waiting for send to finish...
[  456.094718] smpboot: After Startup
[  456.124666] microcode: Load ucode for AP
[  456.129185] microcode: __load_ucode_intel: cp_data = 0x0000000000000000 cp_size = 0x0
000000000000 cp_size = 0x0ack at about 00000000937ed697
[  456.310542] smpboot: Stack at about 000000007168126e
[  456.316238] microcode: mc_cpu_starting: CPU253, err: 3
[  456.359827] CPU253 is up
[  456.362823] smpboot: ++++++++++++++++++++=_---CPU UP  254
[  456.369003] smpboot: Booting Node 1 Processor 254 APIC 0xfd
[  456.375378] smpboot: Setting warm reset code and vector.
[  456.381450] smpboot: Asserting INIT
[  456.385449] smpboot: Waiting for send to finish...
[  456.390924] smpboot: Deasserting INIT
[  456.395144] smpboot: Waiting for send to finish...
[  456.400590] smpboot: #startup loops: 2
[  456.404900] smpboot: Sending STARTUP #1
[  456.409299] smpboot: After apic_write
[  456.413555] smpboot: Startup point 1
[  456.417686] smpboot: Waiting for send to finish...
[  456.423193] smpboot: Sending STARTUP #2
[  456.427619] smpboot: After apic_write
[  456.431869] smpboot: Startup point 1
[  456.435993] smpboot: Waiting for send to finish...
[  456.441476] smpboot: After Startup
[  456.469575] microcode: Load ucode for AP
[  456.474101] microcode: __load_ucode_intel: cp_data = 0x0000000000000000 cp_size = 0x0
[  456.483382] smpboot: Stack [  457.507476] ttyS ttyS0: 1 input overrun(s)
[  457.509389] power_meter ACPI000D:00: Found ACPI power meter.
[  457.519717] serial 00:04: activated
[  457.524889] serial 00:05: activated
[  457.543671] nvme nvme0: 8/0/0 default/read/poll queues
[  457.840429] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  457.847500] ata6: SATA link down (SStatus 4 SControl 300)
[  457.853654] ata5: SATA link down (SStatus 4 SControl 300)
[  457.859819] ata1: SATA link down (SStatus 4 SControl 300)
[  457.865967] ata8: SATA link down (SStatus 4 SControl 300)
[  457.872129] ata4: SATA link down (SStatus 4 SControl 300)
[  457.878292] ata2: SATA link down (SStatus 4 SControl 300)
[  457.884470] ata3: SATA link down (SStatus 4 SControl 300)
[  457.890626] ata7.00: supports DRM functions and may not be fully accessible
[  457.900562] ata7.00: supports DRM functions and may not be fully accessible
[  457.909510] ata7.00: configured for UDMA/133
[  458.532192] virbr0: port 1(ens3) entered disabled state
[  461.085827] igb 0000:27:00.0 ens1: igb: ens1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  461.233851] igb 0000:a8:00.0 ens3: igb: ens3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  461.347436] virbr0: port 1(ens3) entered blocking state
[  461.353412] virbr0: port 1(ens3) entered forwarding state
[  461.377813] igc 0000:01:00.0 enp1s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  469.667476] ast 0000:03:00.0: PM: **** DPM device timeout ****
[  469.674142] Call Trace:
[  469.676983]  <TASK>
[  469.679427]  __schedule+0x27a/0x6e0
[  469.683446]  ? _raw_spin_unlock_irqrestore+0x22/0x40
[  469.689117]  schedule+0x61/0xe0
[  469.692739]  schedule_timeout+0x7a/0xf0
[  469.697126]  ? __pfx_process_timeout+0x10/0x10
[  469.702216]  msleep+0x2d/0x40
[  469.705623]  ast_dp_launch+0x36/0xc0 [ast]
[  469.710328]  ast_post_gpu+0x1fa/0x240 [ast]
[  469.715096]  ast_pm_thaw+0x16/0x20 [ast]
[  469.719554]  pci_pm_thaw+0x44/0xa0
[  469.723450]  ? __pfx_pci_pm_thaw+0x10/0x10
[  469.728146]  dpm_run_callback+0x95/0x200
[  469.732653]  device_resume+0xea/0x210
[  469.736865]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[  469.742413]  async_resume+0x1e/0x60
[  469.746401]  async_run_entry_fn+0x39/0x140
[  469.751098]  process_one_work+0x196/0x3c0
[  469.755691]  worker_thread+0x51/0x3a0
[  469.759902]  ? __pfx_worker_thread+0x10/0x10
[  469.764792]  kthread+0xea/0x120
[  469.768405]  ? __pfx_kthread+0x10/0x10
[  469.772695]  ret_from_fork+0x29/0x50
[  469.776793]  </TASK>
[  469.779346] Kernel panic - not syncing: ast 0000:03:00.0: unrecoverable failure
[  469.787630] CPU: 153 PID: 0 Comm: swapper/153 Tainted: G        W           6.3.0-rc4-2023-03-28-intel-next-02154-g257279c18b21 #1
[  469.800891] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.SYS.0100.D45.2303121331 03/12/2023
[  469.812782] Call Trace:
[  469.815614]  <IRQ>
[  469.817926]  dump_stack_lvl+0x36/0x50
[  469.822124]  panic+0x343/0x350
[  469.825665]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[  469.831240]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[  469.836775]  dpm_watchdog_handler+0x56/0x60
[  469.841571]  call_timer_fn+0x2b/0x140
[  469.845766]  __run_timers.part.0+0x1e7/0x280
[  469.850652]  ? tick_sched_timer+0x73/0x90
[  469.855257]  ? _raw_spin_lock_irq+0x18/0x30
[  469.860041]  ? __hrtimer_run_queues+0x13c/0x2d0
[  469.865220]  ? lapic_timer_shutdown.part.0+0x33/0x50
[  469.870897]  ? lapic_timer_shutdown+0x14/0x20
[  469.875882]  run_timer_softirq+0x35/0x70
[  469.880361]  __do_softirq+0x102/0x31d
[  469.884545]  irq_exit_rcu+0xc1/0x130
[  469.888663]  sysvec_apic_timer_interrupt+0xa2/0xd0
[  469.894150]  </IRQ>
[  469.896589]  <TASK>
[  469.899023]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  469.904892] RIP: 0010:cpuidle_enter_state+0xd0/0x420
[  469.910547] Code: ff ff 8b 53 04 49 89 c5 8b 05 84 b5 ff 00 85 c0 0f 8f e3 02 00 00 31 ff e8 6d ab e7 fe 45 84 ff 0f 85 e3 01 00 00 fb 45 85 f6 <0f> 88 1e 01 00 00 48 8b 04 24 49 63 ce 48 6b d1 68 49 29 c5 48 89
[  469.931691] RSP: 0000:ff85092306c3fe88 EFLAGS: 00000206
[  469.937654] RAX: ff44661abdc40000 RBX: ffb7091ad765af00 RCX: 0000000000000000
[  469.945736] RDX: 0000000000000099 RSI: ffffffff99c06314 RDI: ffffffff99c0ac47
[  469.953814] RBP: 0000000000000003 R08: ffffffca120fb4c4 R09: 000000004b4b4b4b
[  469.961903] R10: 0000000000000010 R11: 00000000000025d6 R12: ffffffff9a27c940
[  469.970007] R13: 0000006d5a5cd0ff R14: 0000000000000003 R15: 0000000000000000
[  469.978117]  ? cpuidle_enter_state+0xc3/0x420
[  469.983056]  cpuidle_enter+0x2d/0x40
[  469.987155]  cpuidle_idle_call+0x101/0x170
[  469.991825]  do_idle+0x74/0xc0
[  469.995336]  cpu_startup_entry+0x1d/0x20
[  469.999822]  start_secondary+0x12d/0x130
[  470.004310]  secondary_startup_64_no_verify+0xe0/0xeb
[  470.010063]  </TASK>
[  470.125520] Kernel Offset: 0x17000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  470.575721] ---[ end Kernel panic - not syncing: ast 0000:03:00.0: unrecoverable failure ]---

[root at emr-2s7 ~]# lspci -vvv -s 03:00.0
03:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52) (prog-if 00 [VGA controller])
        Subsystem: ASPEED Technology, Inc. ASPEED Graphics Family
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 16
        NUMA node: 0
        IOMMU group: 72
        Region 0: Memory at 94000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at 95000000 (32-bit, non-prefetchable) [size=256K]
        Region 2: I/O ports@1000 [size=128]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Kernel modules: ast

Thanks!


Best Regards
Wendy Wang
Tel?(86) 21-6116 7440

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230403/c02f1f2a/attachment-0001.htm>
