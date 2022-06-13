.PHONY: deps build run check test clippy coverage benchmark flamegraph compare_benchmarks

deps:
	cargo install --version 1.1.0 cargo-criterion
	cargo install --version 0.6.1 flamegraph

build:
	cargo build --release

run: 
	cargo run

check:
	cargo check

test:
	cargo test

clippy:
	cargo clippy  -- -D warnings

coverage:
	docker run --security-opt seccomp=unconfined -v "${PWD}:/volume" xd009642/tarpaulin

benchmark:
	cargo criterion --bench cairo_run_benchmark
	@echo 'Report: target/criterion/reports/index.html'

flamegraph:
	cargo flamegraph --root --bench cairo_run_benchmark -- --bench

compare_benchmarks:
	cd benches && ./run_benchmarks.sh
